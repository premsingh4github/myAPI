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
        if($login->mtype == 3){
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
                    'message' => 'invalid credential',
                    'code' => 500
                );
            return Response::json($returnData, 500);
        }
        return $request->only('email','password');

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
    public function socket(){

        
        $host = 'localhost'; //host
        $port = '9000'; //port
        $null = NULL; //null var

        //Create TCP/IP sream socket
        $socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
        //reuseable port
        socket_set_option($socket, SOL_SOCKET, SO_REUSEADDR, 1);

        //bind socket to specified host
        socket_bind($socket, 0, $port);

        //listen to port
        socket_listen($socket);

        //create & add listning socket to the list
        $clients = array($socket);

        //start endless loop, so that our script doesn't stop
        while (true) {
            //manage multipal connections
            $changed = $clients;
            //returns the socket resources in $changed array
            socket_select($changed, $null, $null, 0, 10);
            
            //check for new socket
            if (in_array($socket, $changed)) {
                $socket_new = socket_accept($socket); //accpet new socket
                $clients[] = $socket_new; //add socket to client array
                
                $header = socket_read($socket_new, 1024); //read data sent by the socket
                //perform_handshaking($header, $socket_new, $host, $port); //perform websocket handshake


                //function perform_handshaking($receved_header,$client_conn, $host, $port)
                    
                    $headers = array();
                    $lines = preg_split("/\r\n/", $header);
                    foreach($lines as $line)
                    {
                        $line = chop($line);
                        if(preg_match('/\A(\S+): (.*)\z/', $line, $matches))
                        {
                            $headers[$matches[1]] = $matches[2];
                        }
                    }

                    $secKey = $headers['Sec-WebSocket-Key'];
                    $secAccept =  base64_encode(pack('H*', sha1($secKey . '258EAFA5-E914-47DA-95CA-C5AB0DC85B11')));
                    $upgrade  = "HTTP/1.1 101 Web Socket Protocol Handshake\r\n" .
                    "Upgrade: websocket\r\n" .
                    "Connection: Upgrade\r\n" .
                    "WebSocket-Origin: $host\r\n" .
                    "WebSocket-Location: ws://$host:$port/demo/shout.php\r\n".
                    "Sec-WebSocket-Accept:$secAccept\r\n\r\n";
                    socket_write($socket_new,$upgrade,strlen($upgrade));








                
                socket_getpeername($socket_new, $ip); //get ip address of connected socket
                //$response = mask(json_encode(array('type'=>'system', 'message'=>$ip.' connected'))); //prepare json data


                // function mask($text)
                // {
                $text = json_encode(array('type'=>'system', 'message'=>$ip.' connected'));
                    $b1 = 0x80 | (0x1 & 0x0f);
                    $length = strlen($text);
                    
                    if($length <= 125)
                        $header = pack('CC', $b1, $length);
                    elseif($length > 125 && $length < 65536)
                        $header = pack('CCn', $b1, 126, $length);
                    elseif($length >= 65536)
                        $header = pack('CCNN', $b1, 127, $length);
                    $response = $header.$text;



                  

                //send_message($response); //notify all users about new connection
                foreach($clients as $changed_socket)
                    {

                        @socket_write($changed_socket,$response,strlen($response));
                       
                    }
                
                //make room for new socket
                $found_socket = array_search($socket, $changed);
                unset($changed[$found_socket]);
            }
            
            //loop through all connected sockets
            foreach ($changed as $changed_socket) { 
                
                //check for any incomming data
                while(socket_recv($changed_socket, $buf, 1024, 0) >= 1)
                {
                    //$received_text = unmask($buf); //unmask data

                    $text = $buf;
                        $length = ord($text[1]) & 127;
                        if($length == 126) {
                            $masks = substr($text, 4, 4);
                            $data = substr($text, 8);
                        }
                        elseif($length == 127) {
                            $masks = substr($text, 10, 4);
                            $data = substr($text, 14);
                        }
                        else {
                            $masks = substr($text, 2, 4);
                            $data = substr($text, 6);
                        }
                        $text = "";
                        for ($i = 0; $i < strlen($data); ++$i) {
                            $text .= $data[$i] ^ $masks[$i%4];
                        }
                        $received_text = $text;





                    $tst_msg = json_decode($received_text); //json decode 
                    $user_name = $tst_msg->name; //sender name
                    $user_message = $tst_msg->message; //message text
                    $user_color = $tst_msg->color; //color
                    
                    // //prepare data to be sent to client
                    // $response_text = mask(json_encode(array('type'=>'usermsg', 'name'=>$user_name, 'message'=>$user_message, 'color'=>$user_color)));

                    $text = json_encode(array('type'=>'usermsg', 'name'=>$user_name, 'message'=>$user_message, 'color'=>$user_color));
                        $b1 = 0x80 | (0x1 & 0x0f);
                        $length = strlen($text);
                        
                        if($length <= 125)
                            $header = pack('CC', $b1, $length);
                        elseif($length > 125 && $length < 65536)
                            $header = pack('CCn', $b1, 126, $length);
                        elseif($length >= 65536)
                            $header = pack('CCNN', $b1, 127, $length);
                        $response_text = $header.$text;






                        foreach($clients as $changed_socket)
                        {
                            @socket_write($changed_socket,$response_text,strlen($response_text));
                        }
                    break 2; //exist this loop
                }
                
                $buf = @socket_read($changed_socket, 1024, PHP_NORMAL_READ);
                if ($buf === false) { // check disconnected client
                    // remove client for $clients array
                    $found_socket = array_search($changed_socket, $clients);
                    socket_getpeername($changed_socket, $ip);
                    unset($clients[$found_socket]);
                        $text = json_encode(array('type'=>'system', 'message'=>$ip.' disconnected'));
                        $b1 = 0x80 | (0x1 & 0x0f);
                        $length = strlen($text);
                        
                        if($length <= 125)
                            $header = pack('CC', $b1, $length);
                        elseif($length > 125 && $length < 65536)
                            $header = pack('CCn', $b1, 126, $length);
                        elseif($length >= 65536)
                            $header = pack('CCNN', $b1, 127, $length);
                        $response = $header.$text;
                    foreach($clients as $changed_socket)
                    {
                        @socket_write($changed_socket,$response,strlen($response));
                       
                    }

                }
            }
        }
        // close the listening socket
        socket_close($sock);



         return "ok";



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
