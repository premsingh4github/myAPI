<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Response;
use App\Http\Requests;
use App\Http\Controllers\Controller;
use App\Branch;

class BranchController extends Controller
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
		$data = $request->only('name');
		$branch = new Branch;
		$branch->name = $data['name'];
		$branch->save();
		return $branch;
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
		$data = $request->only('branch_id');
		$branch = Branch::find($data['branch_id']);
		if($branch->delete()){
			 $returnData = array(
                    'status' => 'ok',
                    'message' => 'branch deleted',
                    'code' => 200
                );
            return Response::json($returnData,200);
		}
		else{
			 $returnData = array(
                    'status' => 'fail',
                    'message' => "branch couldn't deleted",
                    'code' => 500
                );
            return Response::json($returnData, 500);
		}
		
		
	}
}
