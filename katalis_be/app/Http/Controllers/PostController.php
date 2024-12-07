<?php

namespace App\Http\Controllers;

use App\Models\Post;
use App\Models\PostComment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class PostController extends Controller
{
    public function index()
    {
        try {
            $posts = Post::with(['user'])->latest()->get();

            return response()->json([
                'status' => true,
                'data' => $posts
            ]);
        } catch (\Exception $e) {
            Log::error('Error fetching posts: ' . $e->getMessage());
            return response()->json([
                'status' => false,
                'message' => 'Failed to fetch posts'
            ], 500);
        }
    }

    public function store(Request $request)
    {
        try {
            $request->validate([
                'content' => 'required|string|max:1000',
            ]);

            $post = Post::create([
                'user_id' => auth()->id(),
                'content' => $request->content,
                'like_count' => 0,
                'comment_count' => 0
            ]);

            $post->load('user');

            return response()->json([
                'status' => true,
                'message' => 'Post created successfully',
                'data' => $post
            ], 201);
        } catch (\Exception $e) {
            Log::error('Error creating post: ' . $e->getMessage());
            return response()->json([
                'status' => false,
                'message' => 'Failed to create post: ' . $e->getMessage()
            ], 500);
        }
    }

    public function like($id)
    {
        try {
            $post = Post::findOrFail($id);
            $userId = auth()->id();

            $existingLike = $post->likes()->where('user_id', $userId)->first();

            if ($existingLike) {
                $existingLike->delete();
                $post->decrement('like_count');
                $isLiked = false;
            } else {
                $post->likes()->create(['user_id' => $userId]);
                $post->increment('like_count');
                $isLiked = true;
            }

            return response()->json([
                'status' => true,
                'message' => $isLiked ? 'Post liked' : 'Post unliked',
                'data' => [
                    'like_count' => $post->like_count,
                    'is_liked' => $isLiked
                ]
            ]);
        } catch (\Exception $e) {
            Log::error('Error liking post: ' . $e->getMessage());
            return response()->json([
                'status' => false,
                'message' => 'Failed to like post'
            ], 500);
        }
    }

    public function comment(Request $request, Post $post)
    {
        try {
            $request->validate([
                'content' => 'required|string|max:1000',
            ]);

            $comment = $post->comments()->create([
                'user_id' => auth()->id(),
                'content' => $request->content
            ]);

            $post->increment('comment_count');

            $comment->load('user');

            return response()->json([
                'status' => true,
                'message' => 'Comment added successfully',
                'data' => $comment
            ], 201);
        } catch (\Exception $e) {
            Log::error('Error creating comment: ' . $e->getMessage());
            return response()->json([
                'status' => false,
                'message' => 'Failed to add comment'
            ], 500);
        }
    }

    public function getComments(Post $post)
    {
        try {
            $comments = $post->comments()
                ->with('user')
                ->latest()
                ->get();

            return response()->json([
                'status' => true,
                'data' => $comments
            ]);
        } catch (\Exception $e) {
            Log::error('Error fetching comments: ' . $e->getMessage());
            return response()->json([
                'status' => false,
                'message' => 'Failed to fetch comments'
            ], 500);
        }
    }
}
