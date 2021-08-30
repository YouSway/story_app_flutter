<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('/stories/latest','StoryController@fetchLatest10');
Route::get('/stories/search/{word}','StoryController@searchByKeyword');
Route::get('/stories/favorites/{array}','StoryController@fetchFavorites');
Route::get('/stories/all/{offset}','StoryController@fetchAllStories');
Route::get('/stories/tag/{tag}/{offset}','StoryController@fetchAllStoriesByTag');
Route::get('/tags/all','StoryTagController@fetchAllTags');
Route::get('/author/all','AuthorController@fetchAllAuthors');
