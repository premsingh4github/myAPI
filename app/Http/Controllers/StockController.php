<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Stock;
use App\Http\Requests;
use App\Http\Controllers\Controller;
use Response;

class StockController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index()
    {
        $stocks = Stock::all();
             $returnData = array(
                    'status' => 'ok',
                    'stocks' => $stocks,
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
        $stock = new Stock;
        $stock->branchId = $request['branchId'];
        $stock->productTypeId = $request['productTypeId'];
        $stock->minQuantity = $request['minQuantity'];
        $stock->onlineQuantity = $request['onlineQuantity'];
        $stock->deliveryCharge = $request['deliveryCharge'];
        $stock->lot = $request['lot'];
       
         if($stock->save()){
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
    public function store()
    {
        //
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
    public function update($id)
    {
        //
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
}
