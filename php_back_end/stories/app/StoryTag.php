<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class StoryTag extends Model
{
    protected $fillable = ['tag','story_id'];
}
