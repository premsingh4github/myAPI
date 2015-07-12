<?php

namespace App;

//use Illuminate\Database\Eloquent\Model;


use Illuminate\Auth\Authenticatable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Auth\Passwords\CanResetPassword;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Contracts\Auth\CanResetPassword as CanResetPasswordContract;

class Member extends Model implements AuthenticatableContract
{
    //

    use Authenticatable;
     public function getAllMember(){
    	$user = Member::select('id','fname','mname','lname')->where('status','=',1)->get();
    	return $user;
    }
}
