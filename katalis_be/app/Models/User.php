<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Spatie\Permission\Traits\HasRoles;
use Illuminate\Database\Eloquent\Casts\Attribute;

class User extends Authenticatable
{
    use HasApiTokens, HasRoles, Notifiable;

    protected $fillable = [
        'name',
        'email',
        'password',
        'google_id',
        'avatar',
        'role',
        'provider',
        'provider_token',
        'last_login_at',
        'email_verified_at'
    ];

    protected $hidden = [
        'password',
        'remember_token',
        'google_id',
        'provider_token'
    ];

    protected $casts = [
        'email_verified_at' => 'datetime',
        'last_login_at' => 'datetime',
        'password' => 'hashed',
    ];

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($user) {
            // Set email as verified if using Google
            if ($user->provider === 'google') {
                $user->email_verified_at = now();
            }
        });

        static::created(function ($user) {
            // Assign default role
            if (!$user->hasRole('admin')) {
                $user->assignRole('user');
            }
        });
    }

    // Accessor untuk avatar
    protected function avatar(): Attribute
    {
        return Attribute::make(
            get: function ($value) {
                if (!$value && $this->provider === 'google') {
                    return $this->google_avatar; // Default ke Google avatar jika ada
                }
                return $value ?? 'default-avatar.png'; // Default avatar jika tidak ada
            }
        );
    }

    public function isAdmin()
    {
        return $this->hasRole('admin');
    }

    public function isUser()
    {
        return $this->hasRole('user');
    }

    public function scopeWithRole($query, $role)
    {
        return $query->whereHas('roles', function ($q) use ($role) {
            $q->where('name', $role);
        });
    }

    public function scopeWithProvider($query, $provider)
    {
        return $query->where('provider', $provider);
    }

    // Method untuk update last login
    public function updateLastLogin()
    {
        $this->last_login_at = now();
        $this->save();
    }
}
