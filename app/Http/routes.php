<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the controller to call when that URI is requested.
|
*/

Route::get('/', function () {
    return view('welcome');
});
Route::post('register','MemberController@store');
Route::post('login','MemberController@login');
Route::group(['prefix'=> 'API','middleware'=>'API'],function(){
	Route::post('/','MemberController@create');
	Route::post('/getUnverifiedMember','MemberController@getUnverifiedMember');
	Route::post('/verifyMember','MemberController@verifyMember');
	Route::post('/isAuthed',function(){
            $returnData = array(
                    'status' => 'ok',
                    'message' => 'logined',
                    'code' => 200
                );
        return Response::json($returnData,200);
	});
	Route::post('/getOnlineUser','MemberController@getOnlineUser');
});