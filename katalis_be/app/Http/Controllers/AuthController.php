<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use GuzzleHttp\Client;

class AuthController extends Controller
{
    public function googleSignIn(Request $request)
    {
        try {
            Log::info('Received auth request', ['data' => $request->all()]);

            $request->validate([
                'access_token' => 'required|string',
            ]);

            // Get user info from Google
            $client = new Client();
            $response = $client->get('https://www.googleapis.com/oauth2/v3/userinfo', [
                'headers' => [
                    'Authorization' => 'Bearer ' . $request->access_token
                ]
            ]);

            $userInfo = json_decode($response->getBody());

            // Create or update user
            $user = User::updateOrCreate(
                ['email' => $userInfo->email],
                [
                    'name' => $userInfo->name,
                    'google_id' => $userInfo->sub,
                    'avatar' => $userInfo->picture ?? null,
                ]
            );

            // Create token
            $token = $user->createToken('auth_token')->plainTextToken;

            return response()->json([
                'status' => true,
                'token' => $token,
                'user' => $user
            ], 200);
        } catch (\Exception $e) {
            Log::error('Google Sign In Error', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);

            return response()->json([
                'status' => false,
                'message' => 'Authentication failed: ' . $e->getMessage()
            ], 500);
        }
    }
}
