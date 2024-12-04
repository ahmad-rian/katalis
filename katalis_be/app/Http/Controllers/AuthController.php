<?php

namespace App\Http\Controllers;

use App\Models\User;
use Laravel\Socialite\Facades\Socialite;
use Illuminate\Http\Request;

class AuthController extends Controller
{
    public function googleSignIn(Request $request)
    {
        try {
            $google_user = Socialite::driver('google')->userFromToken($request->token);

            $user = User::updateOrCreate(
                ['email' => $google_user->email],
                [
                    'name' => $google_user->name,
                    'google_id' => $google_user->id,
                    'avatar' => $google_user->avatar,
                    'password' => bcrypt(rand(100000, 999999))
                ]
            );

            $token = $user->createToken('auth_token')->plainTextToken;

            return response()->json([
                'status' => true,
                'token' => $token,
                'user' => $user
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => $e->getMessage()
            ], 500);
        }
    }
}
