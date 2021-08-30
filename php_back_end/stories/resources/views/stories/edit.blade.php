@extends('base')

@section('main')
    <head>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/css/bootstrap-select.css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/js/bootstrap-select.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.4.0/min/dropzone.min.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.4.0/dropzone.js"></script>
        <style>
            * {
                box-sizing: border-box;
            }

            input[type=text], select, textarea {
                width: 100%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                resize: vertical;
            }

            label {
                padding: 12px 12px 12px 0;
                display: inline-block;
            }

            input[type=submit] {
                background-color: #4CAF50;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                float: right;
            }

            input[type=submit]:hover {
                background-color: #45a049;
            }

            .container {
                border-radius: 5px;
                background-color: #f2f2f2;
                padding: 20px;
            }

            .col-25 {
                float: left;
                width: 25%;
                margin-top: 6px;
            }

            .col-75 {
                float: left;
                width: 75%;
                margin-top: 6px;
            }

            /* Clear floats after the columns */
            .row:after {
                content: "";
                display: table;
                clear: both;
            }

            /* Responsive layout - when the screen is less than 600px wide, make the two columns stack on top of each other instead of next to each other */
            @media screen and (max-width: 600px) {
                .col-25, .col-75, input[type=submit] {
                    width: 100%;
                    margin-top: 0;
                }
            }
        </style>
        <title></title>
    </head>
    <body>

    <h2>{{$story['title']}}</h2>

    <div class="container">
        <form action="/stories/update/{{$story['id']}}" enctype="multipart/form-data" method="post">
            @csrf
            <div class="row">
                <div class="col-25">
                    <label for="title">Title</label>
                </div>
                <div class="col-75">
                    <input type="text" id="title" name="title" placeholder="Title" value="{{$story['title']}}">
                </div>
            </div>
            <div class="row">
                <div class="col-25">
                    <label for="author">Author</label>
                </div>
                <div class="col-75">
                    <select id="author" name="author">
                        <option value="{{$story['authorId']}}">{{$story['author']}}</option>
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="col-25">
                    <label for="intro">Intro</label>
                </div>
                <div class="col-75">
                    <textarea id="intro" name="intro" placeholder="Write something.."
                              style="height:100px" >{{$story['intro']}}</textarea>
                </div>
            </div>
            <div class="row">
                <div class="col-25">
                    <label for="story">Story</label>
                </div>
                <div class="col-75">
                    <textarea id="story" name="story" placeholder="Write something.."
                              style="height:200px">{{$story['story']}}</textarea>
                </div>
            </div>
            <div class="row">
                <div class="col-25">
                    <label for="title">Tags</label>
                </div>
                <div class="col-75">
                    <input type="text" id="tags" name="tags" placeholder="Tags" value="{{$story['tags']}}">
                </div>
            </div>
            <div class="row">
                <div class="col-25">
                    <label for="image">Image</label>
                </div>
                <div class="col-75">
                    <input type="file" name="image" >
                </div>
            </div>
            <div class="row">
                <div class="col-25">
                    <label for="image">Image</label>
                </div>
                <div class="col-75">
                    <img src="{{'/images/'.$story['images']}}">
                </div>
            </div>
            <p></p>
            <div class="row">
                <input type="submit" value="Submit">
            </div>
        </form>
    </div>
@endsection
