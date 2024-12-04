<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\MemberController;
use App\Http\Controllers\EventController;
use Illuminate\Support\Facades\Route;

// Redirect root to login
Route::redirect('/', '/login');

// Dashboard route
Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::resource('events', EventController::class)->middleware('auth');

// Auth protected routes
Route::middleware('auth')->group(function () {

    // Profile routes 
    Route::controller(ProfileController::class)->group(function () {
        Route::get('/profile', 'edit')->name('profile.edit');
        Route::patch('/profile', 'update')->name('profile.update');
        Route::delete('/profile', 'destroy')->name('profile.destroy');
    });

    // Admin only routes
    Route::middleware('role:admin')->group(function () {
        Route::resource('users', UserController::class);
    });

    Route::middleware(['auth', 'role:admin'])->group(function () {
        Route::resource('members', MemberController::class);
    });
});

// Auth routes
require __DIR__ . '/auth.php';
