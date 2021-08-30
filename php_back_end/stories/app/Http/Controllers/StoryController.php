<?php

namespace App\Http\Controllers;

use App\Image;
use App\Story;
use App\StoryTag;
use Exception;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Routing\Redirector;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class StoryController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function index()
    {
        return view('stories.index', compact('stories'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function create()
    {
        $authors = (new AuthorController())->index()->reverse();
        return view('stories.create')->with(['authors'=>$authors]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param Request $request
     * @return RedirectResponse|Redirector
     * @throws Exception
     */
    public function store(Request $request)
    {
        $tagsStr = $request->get('tags');
        $tagsList = explode(",", $tagsStr);
        $request->validate([
            'title'=>'required',
            'story'=>'required',
            'author'=>'required'
        ]);
        $story = new Story([
            'title' => $request->get('title'),
            'intro' => $request->get('intro'),
            'story' => $request->get('story'),
            'author'=>$request->get('author'),
        ]);
        $story->save();
        $image = $request->file('image');
//        $timestamp = (new \DateTime)->getTimestamp();
        $imageName = "{$story['id']}.".$image->extension();
        $image->move(public_path('images'),$imageName);
        $this->compressImage('images/'.$imageName, 'images/thumbnails/'.$imageName, 80);
        foreach ($tagsList as $tag) {
            $tag = new StoryTag([
                'story_id' => $story["id"],
                'tag' => trim($tag)
            ]);
            $tag->save();
        }
        $image = new Image([
            'story_id' => $story["id"],
            'name' => $imageName
        ]);
        $image->save();
        return redirect('/stories/create')->with(['success'=>'Successfully inserted!']);
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
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function edit($id)
    {
        $stories = $this->fetchStoryById($id);
        $story = (array) $stories[0];
        $story['id'] = $id;
        return view('stories.edit')->with(['story'=>$story]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param Story $story
     * @param $id
     * @return int
     */
    public function update(Story $story, $id)
    {
        return  DB::table('stories')
            ->where('id', '=', $id)
            ->update(['title' => $story['title'], 'intro' => $story['intro'],
                'story' => $story['story'], 'author' => $story['author']]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }

    /**
     * Fetch latest 10 stories from the database.
     *
     * @return array
     */
    public function fetchLatest10(){
        return DB::select("SELECT (SELECT name FROM images WHERE story_id=stories.id) as images,
(SELECT name FROM authors WHERE id=stories.author) as author, (SELECT id FROM authors WHERE id=stories.author) as authorId,
(SELECT GROUP_CONCAT(tag) FROM story_tags WHERE story_id = stories.id GROUP BY story_id) as tags, id, title, story,
intro from stories ORDER by id DESC LIMIT 10");
    }

    public function fetchAllStories($offset){
        return DB::select("SELECT (SELECT name FROM images WHERE story_id=stories.id) as images,
(SELECT name FROM authors WHERE id=stories.author) as author, (SELECT id FROM authors WHERE id=stories.author) as authorId,
(SELECT GROUP_CONCAT(tag) FROM story_tags WHERE story_id = stories.id GROUP BY story_id) as tags, id, title, story,
intro from stories ORDER by id DESC LIMIT 10 OFFSET $offset");
    }

    public function fetchAllStoriesByTag($tag, $offset){
        return DB::select("SELECT (SELECT name FROM images WHERE story_id=stories.id) as images,
(SELECT name FROM authors WHERE id=stories.author) as author, (SELECT id FROM authors WHERE id=stories.author) as authorId,
(SELECT GROUP_CONCAT(tag) FROM story_tags WHERE story_id = stories.id GROUP BY story_id) as tags, id, title, story,
intro from stories WHERE id IN (SELECT story_id FROM story_tags WHERE tag = '$tag') ORDER by id DESC LIMIT 10 OFFSET $offset");
    }

    /**
     * @param Request $request
     * @param $word
     * @return array
     */
    public function searchByKeyword(Request $request, $word) {
        return DB::select("SELECT (SELECT name FROM images WHERE story_id=stories.id) as images,
(SELECT name FROM authors WHERE id=stories.author) as author, (SELECT id FROM authors WHERE id=stories.author) as authorId,
(SELECT GROUP_CONCAT(tag) FROM story_tags WHERE story_id = stories.id GROUP BY story_id) as tags, id, title, story,
intro from stories WHERE title LIKE '%$word%' ORDER by id DESC ");
    }

    /**
     * @param Request $request
     * @param $array
     * @return array
     */
    public function fetchFavorites(Request $request, $array) {
        return DB::select("SELECT (SELECT name FROM images WHERE story_id=stories.id) as images,
(SELECT name FROM authors WHERE id=stories.author) as author, (SELECT id FROM authors WHERE id=stories.author) as authorId,
(SELECT GROUP_CONCAT(tag) FROM story_tags WHERE story_id = stories.id GROUP BY story_id) as tags, id, title, story,
intro from stories WHERE id IN $array ORDER by id DESC ");
    }

    /**
     * @param $id
     * @return array
     */
    public function fetchStoryById($id) {
        return DB::select("SELECT (SELECT name FROM images WHERE story_id=stories.id) as images,
(SELECT name FROM authors WHERE id=stories.author) as author, (SELECT id FROM authors WHERE id=stories.author) as authorId,
(SELECT GROUP_CONCAT(tag) FROM story_tags WHERE story_id = stories.id GROUP BY story_id) as tags, id, title, story,
intro from stories WHERE stories.id = '$id'");
    }

    /**
     * @param $source
     * @param $destination
     * @param $quality
     */
    function compressImage($source, $destination, $quality) {

        $info = getimagesize($source);

        if ($info['mime'] == 'image/jpeg')
            $image = imagecreatefromjpeg($source);

        elseif ($info['mime'] == 'image/gif')
            $image = imagecreatefromgif($source);

        elseif ($info['mime'] == 'image/png')
            $image = imagecreatefrompng($source);

        imagejpeg($image, $destination, $quality);

    }

    public function updateStory(Request $request, $storyId)
    {
        $tagsStr = $request->get('tags');
        $tagsList = explode(",", $tagsStr);
        $request->validate([
            'title'=>'required',
            'story'=>'required',
            'author'=>'required'
        ]);
        $story = new Story([
            'title' => $request->get('title'),
            'intro' => $request->get('intro'),
            'story' => $request->get('story'),
            'author'=>$request->get('author'),
        ]);
        $this->update($story, $storyId);
        $image = $request->file('image');
        if(!empty($image)){
            $imageName = "{$storyId}.".$image->extension();
            $image->move(public_path('images'),$imageName);
            $this->compressImage('images/'.$imageName, 'images/thumbnails/'.$imageName, 80);
            $image = new Image([
                'story_id' => $storyId,
                'name' => $imageName
            ]);
            (new ImageController())->update($storyId, $imageName);
        }
        (new StoryTagController())->destroy($storyId);
        foreach ($tagsList as $tag) {
            $tag = new StoryTag([
                'story_id' => $storyId,
                'tag' => trim($tag)
            ]);
            $tag->save();
        }

        return redirect('/stories/create')->with(['success'=>'Successfully inserted!']);
    }
}
