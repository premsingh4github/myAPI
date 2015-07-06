<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Response;
use App\Http\Requests;
use App\Http\Controllers\Controller;
use App\Location;

class LocationController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return Response
     */
    public function create(Request $request)
    {
        $data = $request->only('branch_id','min_quantity','online_quantity','delivery_charge','name');
        $location = new Location;
        $location->branch_id = $data['branch_id'];
        $location->min_quantity = $data['min_quantity'];
        $location->online_quantity = $data['online_quantity'];
        $location->name = $data['name'];
        $location->delivery_charge = $data['delivery_charge'];
        if($location->save()){
            $returnData =  array(
                'status' => 'ok',
                'message' => 'location created',
                'code' => 200 
                );
            return Response::json($returnData,200);
        }
        else{
            $returnData =  array(
                'status' => 'fail',
                'message' => 'location could not created',
                'code' => 500 
                );
            return Response::json($returnData,500);
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
        public function delete(Request $request){
            $data = $request->only('location_id');
            $branch = Location::find($data['location_id']);
            if($branch->delete()){
                 $returnData = array(
                        'status' => 'ok',
                        'message' => 'location deleted',
                        'code' => 200
                    );
                return Response::json($returnData,200);
            }
            else{
                 $returnData = array(
                        'status' => 'fail',
                        'message' => "location couldn't deleted",
                        'code' => 500
                    );
                return Response::json($returnData, 500);
            }
            
            
        }
}
