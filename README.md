jQuery.sexyPost
===============

`jQuery.sexyPost` attaches callback hooks to a form's submit event. Allowing your webapp, for example, to monitor the progress
of a form send or a file upload.

Requirements
------------
+ jQuery version 1.6.x
+ HTML5 ready browsers (eg: Safari 5.0+, Firefox 4.0+, Chrome 6.0+)

Usage
-----
Drop the javascript files in your webapp's `public/javascripts` directory or symlink to it.
Then reference the plugin (obviously it requires jQuery):

    <script src='/javascripts/jquery.js' type='text/javascript'></script>
    <script src='/javascripts/jquery.sexypost.js' type='text/javascript'></script>
    
Or to reference the production release:

    <script src='/javascripts/jquery.sexypost-1.0.4.min.js' type='text/javascript'></script>
    
Declare your form as usual:

    <form method="POST" action="/" enctype="multipart/form-data">
      <input name="attachments[] id="attachments" type="file" multiple="multiple" />
      <input name="description" id="description" type="text" />
      <input type="submit" />
    </form>
    
    <div id="status" />
    
Then sexify it:

    <script type="text/javascript">
      $(document).ready(function(){
        $(form).sexyPost({
          progress: function(event, completed, loaded, total) {
            $("#status").text("Uploading: " + (completed * 100).toFixed(2) + "% complete...")
          },
          complete: function(event, responseText) {
            $("#status").text("Upload complete.")
          }
        })
      })
    </script>

Submit Events
-------------
`jQuery.sexyPost` makes the following events available on form submission:


    start   : function(event) { },                           // triggered right before the form is submitted
    progress: function(event, completed, loaded, total) { }, // repeatedly triggered while the form is being submitted
    complete: function(event, responseText) { },             // triggered after the form has been fully submitted
    error   : function(event) { },                           // triggered if an error occurs during submission
    abort   : function(event) { }                            // triggered if an abort() signal is received

And these properties:

    async        : true                                      // set to true to submit the form asynchronously
    autoclear    : false                                     // automatically clear the form on successful post
    requestHeader: null,                                     // for additional request headers to send

Submit Triggers
---------------
You may also assign other elements in the form as submit triggers. 
You do this by assigning the `submit-trigger` class:

    <input name="attachments[] id="attachments" type="file" multiple="multiple" class="submit-trigger" />
    <img src="/images/button.png" class="submit-trigger" />
    
Now when the user has clicked on the button image or selected a file (or files) the form is automatically submitted.

Request Headers
---------------
You can specify additional request headers to send by creating an array like so:

    var headers = new Array();
    headers["Accept"] = "text/*, text/html, text/html;level=1, */*";
    
And setting the `requestHeader` property when binding `sexyPost` to your form elements:

    $(form).sexyPost({
      requestHeader: header,
      
      progress: function(...) { ... },
      complete: function(...) { ... }
    })

How It Works
------------
The plugin uses XmlHttpRequest Level 2 and the new FormData interface supported by HTML5 ready browsers to send your form.
Read: [XmlHttpRequest Level 2](http://dev.w3.org/2006/webapi/XMLHttpRequest-2/Overview.html) for more information.

Sample Application
------------------
For reference I've included a sample application that uses the plugin. It's self-hosting using [Sinatra](http://www.sinatrarb.com/)
and [Haml](http://haml-lang.com/). To see it in action:

    cd sample-app
    bundle install
    ./app &
    open http://localhost:4567/

License
-------
Dual licensed under the MIT or GPL Version 2 licenses.

Credits
-------
* [jurisgalang](https://github.com/jurisgalang) (owner)
* [chatgris](https://github.com/chatgris) (contributor)
* [codler](https://github.com/codler) (feedback)


---

Copyright &copy; 2010 - 2011, Juris Galang. All Rights Reserved.

