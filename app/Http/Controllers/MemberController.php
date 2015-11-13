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
use App\MemberType;
use App\Account;
use Validator;
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
    public function index(Request $request)
    {   
        $members = Member::select('id','fname','mname','lname','mtype','username')->where('status','=',1)->get();
        $login = Login::where('remember_token','=',$request->header('token'))->where('login_from','=',$request->ip())->join('members', 'members.id', '=', 'logins.member_id')->where('logins.status','=','1')->first();
        if($login->mtype == 3 || $login->mtype == 1){
            foreach ($members as $member) {
                $accounts = Account::where('memberId','=',$member->id)->get();
                $amount = 0;
                foreach ($accounts as $account) {
                   if($account->type == 1){
                        $amount += $account->amount;
                   }
                   else{
                         $amount -= $account->amount;
                   }
                 
                }
                $member->amount = $amount; 
                $user[] = $member;
            }
        }
        else{
             //$user = $members;
             foreach ($members as $member) {
                if($member->id == $login->member_id){
                    $accounts = Account::where('memberId','=',$member->id)->get();
                    $amount = 0;
                    foreach ($accounts as $account) {
                       if($account->type == 1){
                            $amount += $account->amount;
                       }
                       else{
                             $amount -= $account->amount;
                       }
                    }
                    $member->amount = $amount;
                }                  
                 $user[] = $member;
             }
        }
         $returnData = array(
                'status' => 'ok',
                'members' => $user,
                'user' => $login->member_id,
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
        $member->mtype = 6;
        $member->password = Hash::make('password');
        if(isset($request['agent']) && $agent = Member::where('username','=',$request['agent'])->where('mtype','=','7')->first()){
            $member->agentId = $agent->id;
        }
        if($member->save()){
            $returnData = array(
                    'status' => 'ok',
                    'message' => 'Stock created',
                    'member' => $member,
                    'code' =>200
                );
            return Response::json($returnData, 200);
        }
        else{
            $returnData = array(
                    'status' => 'fail',
                    'message' => 'member not created',
                    'code' =>500
                );
            return Response::json($returnData, 200);
        }
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
        if(Auth::attempt($data) && Auth::user()->status == '1'){
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
                    'id' =>  Auth::user()->id,
                    'code' =>200
                );

            return Response::json($returnData, 200);
        }else{
            $returnData = array(
                    'status' => 'fail',
                    'message' => 'invalid credential'
                );
            return Response::json($returnData, 401);
        }
      
    }
    public function getUnverifiedMember(Request $request){
         $user = Login::where('remember_token','=',$request->header('token'))->where('login_from','=',$request->ip())->join('members', 'members.id', '=', 'logins.member_id')->where('logins.status','=','1')->first();
        if($user->mtype == 1){
            $members = Member::select('*')->where('status','=','0')->get();
        }
        else{
            $members = [];
        }
        
        return Response::json(array(
                'status' => 'ok',
                'members'=> $members,
                'code' => 200
            ));
    }
    public function verifyMember(Request $request){
         $user = Login::where('remember_token','=',$request->header('token'))->where('login_from','=',$request->ip())->join('members', 'members.id', '=', 'logins.member_id')->where('logins.status','=','1')->first();
        if($user->mtype != 1){
            $returnData = array(
                   'status' => 'fail',
                   'mesage' => 'insufficient permision',
                   'code' =>403
               );
               return $returnData ;
        }
        $rules = array(
          'username' => 'required|numeric|unique:members'
      );

    $validator = Validator::make($request->all(), $rules);

    
    if ($validator->fails())
        {
            $returnData = array(
                    'status' => 'fail',
                    'message' => 'Invalid Client Code',
                    'code' =>422
                );
            return Response::json($returnData, 422);
        }
        $data = $request->only('member_id','username','password','mtype');
        $member = Member::find($data['member_id']);
        $member->username = $data['username'];
        $member->password = Hash::make($data['password']);
        $member->mtype = $data['mtype'];
        $member->status = 1;

        //return $member ;
        if($member->save()){
            $new = Member::select('id','fname','mname','lname','mtype','username')->where('id','=',$member->id)->first();
            $returnData = array(
                    'status' => 'ok',
                    'message' => 'member verified',
                    'code' =>200,
                    'member' => $new
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
    public function getOnlineMember(){

            $login = new Member;
             $returnData = array(
                    'status' => 'ok',
                    'members' => $login->getAllMember(),
                    'code' =>200
                );
                return $returnData ; 
    }
    public function logout(Request $request){
         if(Login::where('remember_token','=',$request->header('token'))->where('status','=','1')->where('login_from','=',$request->ip())->update(array('status' => 0))){
                $returnData = array(
                    'status' => 'ok',
                    'message' => 'logout success',
                    'code' =>200
                );
                return $returnData ; 
         }
         else{
            $returnData = array(
                    'status' => 'fail',
                    'message' => 'Invalid token',
                    'code' =>500
                );
            return $returnData ;
         }
         
        
    }
   
    public function getMemberType(){
        $MemberTypes = MemberType::all();
             $returnData = array(
                    'status' => 'ok',
                    'memberTypes' => $MemberTypes,
                    'code' =>200
                );
                return $returnData ;
    }
    public function account(Request $request){
        $login = Login::where('remember_token','=',$request->header('token'))->where('status','=','1')->where('login_from','=',$request->ip())->first();
        $account = new Account;
        $account->addedBy = $login->member_id;
        $account->memberId = $request['memberId'];
        $account->amount = $request['amount'];
        $account->type = $request['type'];
        $account->save();
        $returnData = array(
               'status' => 'ok',
               'account' => $account,
               'message' => "Account updated Successfully",
               'code' =>200,
               'account' =>$account
           );
           return $returnData ;

    }
    public function addMember(Request $request){
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
        $member->mtype = $request['mtype'];
        $member->password = Hash::make('password');
        if(isset($request['agent']) && $agent = Member::where('username','=',$request['agent'])->first()){
            $member->agentId = $agent->id;
        }
        if($member->save()){
            $returnData = array(
                    'status' => 'ok',
                    'message' => 'Stock created',
                    'member' => $member,
                    'code' =>200
                );
            return Response::json($returnData, 200);
        }
        else{
            $returnData = array(
                    'status' => 'fail',
                    'message' => 'member not created',
                    'code' =>500
                );
            return Response::json($returnData, 200);
        }
    }

}
