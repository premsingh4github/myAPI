<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Stock;
use App\Http\Requests;
use App\Http\Controllers\Controller;
use Response;
use App\Login;
use App\ClientStock;
use App\Product,App\AddProduct;
use App\Branch;
use App\Account, App\StockType,Input;



class StockController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    
    public function index(Request $request)
    {
        
        $login = Login::where('remember_token','=',$request->header('token'))->where('login_from','=',$request->ip())->join('members', 'members.id', '=', 'logins.member_id')->where('logins.status','=','1')->first();
        $stockTypes = StockType::all();
        
        if($login->mtype == 1){
            $stocks = Stock::orderBy('stockTypeId')->get();
            if(count($stocks) > 0){
                foreach ($stocks as $stock) {
                    $clientStocks = ClientStock::where('stockId','=',$stock->id)->where('status','=',0)->get();
                    $stock->request = $clientStocks;
                    //$stockProducts = AddProduct::sum('quantity')->where('stockId',$stock->id);
                    $stock->quantity = AddProduct::where('stockId',$stock->id)->sum('quantity');
                    $data[] = $stock; 
                }
            }
            else{
              $data = $stocks;  
            }
            
        }
        else{
            $stocks = Stock::orderBy('stockTypeId')->where('stockTypeId',3)->get();
           if(count($stocks) > 0){
               foreach ($stocks as $stock) {
                   $stock->quantity = AddProduct::where('stockId',$stock->id)->sum('quantity');
                   $data[] = $stock; 
               }
           }
           else{
             $data = $stocks;  
           }   
        }

             $returnData = array(
                    'status' => 'ok',
                    'stocks' => $data,
                    'stockTypes' => $stockTypes,
                    'code' =>200
                );
                return $returnData ;
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return Response
     */
    public function create(Request $request)
    {
        //return $request['branchId'];
        $login = Login::where('remember_token','=',$request->header('token'))->where('login_from','=',$request->ip())->join('members', 'members.id', '=', 'logins.member_id')->where('logins.status','=','1')->first();
        $stock = Stock::where('stockTypeId',$request['stockTypeId'])->where('branchId',$request['branchId'])->where('productTypeId',$request['productTypeId'])->first();
        if(count($stock)){
             $stockProduct = new AddProduct;
             $stockProduct->stockId = $stock->id;
             $stockProduct->quantity = $request['onlineQuantity'];
             $stockProduct->addedBy = $login->member_id;
             $stockProduct->added = 1;
             $stockProduct->save();
            $returnData = array(
                    'status' => 'added',
                    'stock' => $stock,
                    'stockProduct' => $stockProduct,
                    'code' =>200
                );
             return Response::json($returnData, 200);
        }
        else{
            try{
              $stock = new Stock ; 
              $stock->fill(Input::all());
              $stock->addedBy = $login->member_id;
              $stock->save();
              $stockProduct = new AddProduct;
              $stockProduct->stockId = $stock->id;
              $stockProduct->quantity = $request['onlineQuantity'];
              $stockProduct->addedBy = $login->member_id;
              $stockProduct->added = 1;
              $stockProduct->save();
              $stock->quantity = $request['onlineQuantity'];
              $returnData = array(
                      'status' => 'created',
                      'stockProduct' => $stockProduct,
                      'stock' => $stock,
                      'code' =>200
                  );
              return Response::json($returnData, 200);
          }catch(\Exception $e){
              return $e->getMessage();
          }
        }
    }

    /**
     * Store a newly created resource in storage.
     *
     * @return Response
     */
    public function store(Request $request)
    {
        $login = Login::where('remember_token','=',$request->header('token'))->where('logins.status','=','1')->where('login_from','=',$request->ip())->join('members','members.id','=','logins.member_id')->first();
        $stock = Stock::find($request['stockId']);
        $branch = Branch::find($stock->branchId);
        $account = new Account;
        $account->getAccount($login->member_id); 
        $productType = Product::find($stock->productTypeId);
        $realQuantity = $productType->lot_size * $request['amount'];
        $realDeliveryCharge = ($realQuantity/10) * $branch->delivery_charge; 
        $cost = (($productType->commision + $productType->margin) * $request['amount']) + $realDeliveryCharge ;
        $clientStock = new ClientStock;
        $clientStock->memberId = $login->member_id;
        $clientStock->stockId = $request['stockId'];
        $clientStock->amount = ($productType->lot_size * $request['amount']);
        $clientStock->status = 0;
        $clientStock->delivery_date = $request['delivery_date'];
        if($account->getAccount($login->member_id) < $cost){
            $returnData = array(
                   'status' => 'fail',
                   'message' => "Insufficient balance",
                   'code' =>400
               );
        }
        elseif($stock->onlineQuantity < $clientStock->amount){
            $returnData = array(
                   'status' => 'fail',
                   'message' => "Insufficient stock quantity",
                   'code' =>400
               );
        }
        else{
            $clientStock->cost = $cost;
            $clientStock->save();
            $account = new Account;
            $account->memberId = $login->member_id;
            $account->addedBy = 0;
            $account->type = 0;
            $account->amount = $cost;
            $account->token_id = $clientStock->id;
            $account->save();
            $returnData = array(
                   'status' => 'ok',
                   'clientStock' => $clientStock,
                   'message' => "Your request completed successfully",
                   'code' =>200
               );

        }

           return $returnData ;
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  int  $id
     * @return Response
     */
    public function update(Request $request)
    {
        $login = Login::where('remember_token','=',$request->header('token'))->where('status','=','1')->where('login_from','=',$request->ip())->first();
        
        if($login->mtype < 6 ){

            $add_product = new AddProduct;
            $stock = Stock::find($request['stockId']);
            $productType = Product::find($stock->productTypeId);
            $add_product->stockId = $request['stockId'];
            $add_product->quantity = $request['quantity'] * $productType->lot_size;
            $add_product->addedBy = $login->member_id;
            $add_product->save();
            $stock->onlineQuantity += $add_product->quantity;
            $stock->save();
            $returnData = array(
                    'status' => 'ok',
                    'message' => 'Stock updatd successfully',
                    'code' => 200,
                    'stock' => $stock
                    );
        }
        else{
            $returnData = array(
                    'status' => 'fail',
                    'message' => 'Insufficient permission',
                    'code' => 400
                );
        }
       return $returnData;

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return Response
     */
    public function destroy($id)
    {
        //
    }
    public function approveRequest(Request $request){
        if($clientStock = ClientStock::find($request['requestId'])){
            if($request['status'] == 1){
                $clientStock->status = $request['status'];
                if($clientStock->save()){
                    $stock = Stock::find($clientStock->stockId);
                    $stock->onlineQuantity -= $clientStock->amount;
                    $returnData = array(
                            'status' => 'ok',
                            'message' => 'request approved successfully',
                            'clientStock' => $clientStock,
                            'code' =>200
                        );
                }
            }
            else{
                $clientStock->status = 2;
                $clientStock->save();
                $account = new Account;
                $account->memberId = $clientStock->memberId;
                $account->token_id = $clientStock->id;
                $account->type = 1;
                $account->amount = $clientStock->cost;
                $account->addedBy = 0;
                $account->save();
                $returnData = array(
                        'status' => 'ok',
                        'message' => 'request rejected successfully',
                        'clientStock' => $clientStock,
                        'code' =>200
                    );

            }
            
        }
        else{
            $returnData = array(
                    'status' => 'fail',
                    'message' => 'invalid repquest',
                    'code' => '400'
                );
        }
        return $returnData; 
    }
    public function addStockProduct(Request $request){

    }
    public function getStockTypes(){
        $stockTypes = StockType::all();
        $returnData = array(
                    'status' => 'ok',
                    'stockTypes' => $stockTypes,
                    'code' => '200'
                );
        return Response::json($returnData,200);
    }
}
