<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Stock;
use App\Http\Requests;
use App\Http\Controllers\Controller;
use Response;
use App\Login;
use App\ClientStock;
use App\AddProduct;

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
        $stocks = Stock::all();
        if($login->mtype == 1){
            foreach ($stocks as $stock) {
                $clientStocks = ClientStock::where('stockId','=',$stock->id)->where('status','=',0)->get();
                $stock->request = $clientStocks;
                $data[] = $stock; 
            }
        }
        else{
            $data = $stocks;
        }
             $returnData = array(
                    'status' => 'ok',
                    'stocks' => $data,
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
        $stock = new Stock;
        $stock->branchId = $request['branchId'];
        $stock->productTypeId = $request['productTypeId'];
        $stock->lot = $request['lot'];
        $stock->minQuantity = ($request['minQuantity'] * $stock->lot);
        $stock->onlineQuantity = ($request['onlineQuantity'] * $stock->lot);
        $stock->deliveryCharge = $request['deliveryCharge'];
        
         if($stock->save()){
            $add_product = new AddProduct;
            $add_product->stockId = $stock->id;
            $add_product->quantity = ($stock->onlineQuantity * $stock->lot) + ($stock->minQuantity * $stock->lot) ;
            $add_product->addedBy = $login->member_id;
            $add_product->save();
            $returnData = array(
                    'status' => 'ok',
                    'message' => 'Stock created',
                    'stock' => $stock,
                    'code' =>200
                );
            return Response::json($returnData, 200);
        }
        else{
            $returnData = array(
                    'status' => 'fail',
                    'message' => 'Stock not created',
                    'code' =>500
                );
            return Response::json($returnData, 200);
        }
    }

    /**
     * Store a newly created resource in storage.
     *
     * @return Response
     */
    public function store(Request $request)
    {
        $login = Login::where('remember_token','=',$request->header('token'))->where('status','=','1')->where('login_from','=',$request->ip())->first();
        $stock = Stock::find($request['stockId']);
        
        $clientStock = new ClientStock;
        $clientStock->memberId = $login->member_id;
        $clientStock->stockId = $request['stockId'];
        $clientStock->amount = ($stock->lot * $request['amount']);
        if($stock->onlineQuantity >= $clientStock->amount ){            
            $clientStock->status = 0;
            $clientStock->save();
            $returnData = array(
                   'status' => 'ok',
                   'clientStock' => $clientStock,
                   'message' => "Your request completed successfully",
                   'code' =>200
               );
        }
        else{
            $returnData = array(
                   'status' => 'fail',
                   'message' => "Insufficient stock quantity",
                   'code' =>400
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
            $add_product->stockId = $request['stockId'];
            $add_product->quantity = $request['quantity'] * $stock['lot'];
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
            $clientStock->status = $request['status'];
            if($clientStock->save()){
                $returnData = array(
                        'status' => 'ok',
                        'message' => 'request approved successfully',
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
}
