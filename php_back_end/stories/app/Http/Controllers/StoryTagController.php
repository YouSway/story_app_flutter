<?php

namespace App\Http\Controllers;

use App\StoryTag;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class StoryTagController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $request->validate([
            'story_id'=>'required',
            'tag'=>'required'
        ]);
        $tag = new StoryTag([
            'story_id' => $request->get('story_id'),
            'tag' => $request->get('tag_id')
        ]);
        $tag->save();
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return int
     */
    public function destroy($id)
    {
        return  DB::table('story_tags')->where("story_id","=",$id)->delete();
    }

    /**
     * @return StoryTag[]|\Illuminate\Database\Eloquent\Collection
     */
    public function fetchAllTags() {
        return DB::select("SELECT id, tag FROM story_tags GROUP BY tag ORDER BY COUNT(*) DESC");
    }
}
