<?php

namespace App\Http\Controllers;

use App\Models\Member;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;

class MemberController extends Controller
{
    public function __construct()
    {
        // Middleware applied only to certain routes
        $this->middleware(['auth', 'role:admin'])->except(['index', 'search', 'view']);
    }

    public function view()
    {
        try {
            $members = Member::latest()->paginate(10);
            return view('members.index', compact('members'));
        } catch (\Exception $e) {
            Log::error('Error in member index: ' . $e->getMessage());
            return back()->with('error', 'Unable to load members list.');
        }
    }

    /**
     * List all members (API response in JSON format).
     */
    public function index(Request $request)
    {
        try {
            $members = Member::query();

            // Apply search filter if `nim` is provided
            if ($request->has('nim')) {
                $members->where('nim', 'like', '%' . $request->query('nim') . '%');
            }

            return response()->json($members->latest()->get(), 200);
        } catch (\Exception $e) {
            Log::error('Error in member index: ' . $e->getMessage());
            return response()->json(['error' => 'Failed to fetch members'], 500);
        }
    }

    /**
     * Search members by NIM or Name.
     */
    public function search(Request $request)
    {
        try {
            $query = $request->query('nim');

            $members = Member::where('nim', 'like', "%$query%")
                ->orWhere('name', 'like', "%$query%")
                ->get();

            return response()->json($members, 200);
        } catch (\Exception $e) {
            Log::error('Error in member search: ' . $e->getMessage());
            return response()->json(['error' => 'Failed to search members'], 500);
        }
    }

    /**
     * Store a new member (not typically used for API).
     */
    public function store(Request $request)
    {
        try {
            $validated = $request->validate([
                'nim' => 'required|string|max:20|unique:members',
                'name' => 'required|string|max:255',
                'batch_year' => 'required|integer|min:2000|max:' . (date('Y')),
                'faculty' => 'required|string|max:255',
                'study_program' => 'required|string|max:255',
                'profile_image' => 'nullable|image|mimes:jpg,jpeg,png|max:2048',
            ]);

            if ($request->hasFile('profile_image')) {
                $validated['profile_image'] = $request->file('profile_image')->store('profiles', 'public');
            }

            Member::create($validated);

            return response()->json(['success' => 'Member created successfully.'], 201);
        } catch (\Exception $e) {
            Log::error('Error creating member: ' . $e->getMessage());
            return response()->json(['error' => 'Failed to create member.'], 500);
        }
    }

    public function edit(Member $member)
    {
        try {
            return view('members.edit', compact('member'));
        } catch (\Exception $e) {
            Log::error('Error in member edit: ' . $e->getMessage());
            return back()->with('error', 'Unable to load edit form.');
        }
    }

    public function update(Request $request, Member $member)
    {
        try {
            // Validasi data
            $validated = $request->validate([
                'nim' => 'required|string|max:20|unique:members,nim,' . $member->id,
                'name' => 'required|string|max:255',
                'batch_year' => 'required|integer|min:2000|max:' . (date('Y')),
                'faculty' => 'required|string|max:255',
                'study_program' => 'required|string|max:255',
                'profile_image' => 'nullable|image|mimes:jpg,jpeg,png|max:2048', // Validasi file gambar
            ]);

            // Periksa jika ada file gambar baru yang diunggah
            if ($request->hasFile('profile_image')) {
                // Hapus gambar lama jika ada
                if ($member->profile_image && Storage::disk('public')->exists($member->profile_image)) {
                    Storage::disk('public')->delete($member->profile_image);
                }

                // Simpan gambar baru
                $validated['profile_image'] = $request->file('profile_image')->store('profiles', 'public');
            }

            // Update data member
            $member->update($validated);

            return redirect()->route('members.index')
                ->with('success', 'Member updated successfully.');
        } catch (\Exception $e) {
            Log::error('Error updating member: ' . $e->getMessage());
            return back()->withInput()
                ->with('error', 'Failed to update member.');
        }
    }


    public function destroy(Member $member)
    {
        try {
            // Hapus gambar jika ada
            if ($member->profile_image) {
                Storage::disk('public')->delete($member->profile_image);
            }

            $member->delete();

            return redirect()->route('members.index')
                ->with('success', 'Member deleted successfully.');
        } catch (\Exception $e) {
            Log::error('Error deleting member: ' . $e->getMessage());
            return back()->with('error', 'Failed to delete member.');
        }
    }

    public function apiIndex()
    {
        try {
            $members = Member::latest()->get();
            return response()->json([
                'data' => $members,
                'message' => 'Success'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to fetch members'
            ], 500);
        }
    }

    public function apiSearch(Request $request)
    {
        try {
            $query = $request->query('nim');
            $members = Member::where('nim', 'like', "%$query%")
                ->orWhere('name', 'like', "%$query%")
                ->get();
            return response()->json([
                'data' => $members,
                'message' => 'Success'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to search members'
            ], 500);
        }
    }
}
