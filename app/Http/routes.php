<?php
header("Access-Control-Allow-Origin: *");
header('Access-Control-Allow-Methods :POST, GET, OPTIONS, PUT, DELETE');
header('Access-Control-Allow-Headers : X-Requested-With, content-type,token');
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
Route::get('index','MemberController@index');
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
    Route::post('/getOnlineMember','MemberController@getOnlineMember');
    Route::post('/logout','MemberController@logout');
    Route::post('/createBranch','BranchController@create');
    
    Route::post('/createStock','StockController@create');
    Route::post('/getStocks','StockController@index');
    Route::post('/creatProduct','ProductController@create');
    Route::post('/getProducts','ProductController@index');
    Route::post('/getMemberTypes','MemberController@getMemberType');
    Route::post('/getMembers','MemberController@index');
    Route::post('/addClientStock','StockController@store');
    Route::post('/addMember','MemberController@addMember');
    Route::group(['middleware' => 'Account'],function(){
        Route::post('/addAccount','MemberController@account');
        Route::post('/getAccounts','AccountController@index');
    });
    Route::post('/approveRequest','StockController@approveRequest');
    Route::post('/updateStock','StockController@update');
    // Route::group(['middleware' => 'deal'],function(){
        
    // });
    Route::post('/getNotices','NoticeController@index');
    Route::post('/sendNotice','NoticeController@create');
    Route::post('/systemSwitch','MemberController@systemSwitch');
});
Route::post('/getBranch','BranchController@index');
Route::post('/connectSocket','SocketController@create');
Route::get('/connectSocket','SocketController@create');