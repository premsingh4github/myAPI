<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;
use App\Member;
use Auth;
use Hash;
use App\User;
use Response;
use App\Login;

class MemberController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    // public function __construct()
    // {
    //     $this->middleware('API', ['except' => 'getLogout']);
    // }
    public function index()
    {
        return "index";
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return Response
     */
    public function create(Request $request)
    {
        $login = Login::where('remember_token','=',$request->header('token'))->where('status','=','1')->where('login_from','=',$request->ip())->count();
        //$login = "empty";
        return $login;
    }

    /**
     * Store a newly created resource in storage.
     *
     * @return Response
     */
    public function store(Request $request)
    {
        $data = $request->only('fname','email','mname','lname','address','identity','nationality','dob','ban','cNumber','mNumber');
        //return $data;
        $member = new Member;
        $member->fname = $data['fname'];
        $member->mname = $data['mname'];
        $member->lname = $data['lname'];
        $member->email = $data['email'];
        $member->address = $data['address'];
        $member->identity = $data['identity'];
        $member->nationality = $data['nationality'];
        $member->dob = $data['dob'];
        $member->ban = $data['ban'];
        $member->cNumber = $data['cNumber'];
        $member->mNumber = $data['mNumber'];
        $member->status = "0";
        $member->mtype = "0";
        $member->password = Hash::make('password');
        $member->save();
        return $member->id;
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
        $member = Member::find(2);
        //return $member;
        $member->username = $request->only('username');
        return $member->username;
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
    public function login(Request $request){
        $data = $request->only('username','password');
        if(Auth::attempt($data)){
            $login = new Login;
            $login->member_id = Auth::user()->id;
            $login->remember_token = str_random(15);;
            $login->status = 1;
            $login->login_from = $request->ip();
            $login->save();
            $token = Auth::user()->id.$request->ip();
            $returnData = array(
                    'status' => 'ok',
                    'message' => 'login success',
                    'token' => $login->remember_token,
                    'code' =>200
                );
            return Response::json($returnData, 200);
        }else{
            $returnData = array(
                    'status' => 'fail',
                    'message' => 'invalid credential',
                    'code' => 500
                );
            return Response::json($returnData, 500);
        }
        return $request->only('email','password');

    }
    public function getUnverifiedMember(){
        $members = Member::select('id')->where('status','=','0')->get();
        return Response::json(array(
                'members'=> $members
            ));
    }
    public function verifyMember(Request $request){
        $data = $request->only('member_id','username','password','mtype');
        $member = Member::find($data['member_id']);
        $member->username = $data['username'];
        $member->password = Hash::make($data['password']);
        $member->mtype = $data['mtype'];
        $member->status = 1;

        //return $member ;
        if($member->save()){
            $returnData = array(
                    'status' => 'ok',
                    'message' => 'member verified',
                    'code' =>200
                );
            return Response::json($returnData, 200);
        }
        else{
            $returnData = array(
                    'status' => 'fail',
                    'message' => 'member verified',
                    'code' =>500
                );
            return Response::json($returnData, 200);
        }
    }
    public function getOnlineUser(){
        return Login::getOnlineUser();
    }

}
