// Home page background

function setHomepageImage() {
    //
    var images = [
        "http://scale.ydc2.yale.edu/iiif/55c5ba26-f106-4876-b3f8-1c142a617735/1160,800,1910,730/900,/0/native.jpg",
        //"http://scale.ydc2.yale.edu/iiif/56f56424-e975-4c7d-b0fc-2867e65d3b36/1404,1350,1880,720/940,/0/native.jpg"
    ]
    var image_index = Math.floor((Math.random() * images.length))
    var home_page_bg_image = images[image_index];
    $("#ysm_header.home").css('background-image', 'url(' + home_page_bg_image + ')');
}

// CDS
var jp2Url=null;
function add(assetId, data) {
    contentItem = data[assetId]
    var uuid = contentItem.contentId;
    var skip;
    if((contentItem.derivatives[1].format)=='application/pdf')skip=true;
    var items = [];
    var thumbnailUrl = "(no thumbnail available)";
    $.each(contentItem.derivatives, function(key, derivative) {
        var captcha = derivative.captcha;
        var cas = derivative.cas;
        var format = derivative.format;
        var formatId = derivative.formatId;
        var label = derivative.label;
        var xPixels = derivative.pixelsX;
        var yPixels = derivative.pixelsY;
        var bytes = derivative.sizeBytes
        var url = derivative.url;
        var size = "";
        if (bytes > 1024 * 1024) {
            size = Math.round((bytes / (1024 * 1024)) * 10) / 10   + " MB";
        } else {
            size = Math.round((bytes / 1024) * 10) / 10 + " KB";
        }


        label = label + " (" + size + ")";


        if (formatId == 2) {
            thumbnailUrl = url;
        }

        if (formatId == 7) {
            jp2Url="http://scale.ydc2.yale.edu/iiif/"+uuid+"/info.json"
        }



        if(formatId != 7 && (!skip||formatId == 0))
            $("#image_size").append($('<option></option>').val(url + "?download=true").text(label));

     });

    $("#thumbnail_url_link").append(thumbnailUrl);
}

function download_image() {
    $url = $("#image_size").val();
    $label = $("#image_size option:selected").text();
    if ($label.indexOf("Print") > -1) {
        window.open($url, 'Captcha');
    } else {
        document.location = $url;
    }
}

$(document).ready(function(){
    setHomepageImage();

    assetId = $('#assetId').text();
    if (assetId) {

        if (assetId != null) {
            $.getJSON(cdsBaseUrl + "/info/assetid/" + assetId + "?callback=?&output=jsonp",
                {},
                function(data) { add( assetId, data); }
            );
        }
    }

    var $container = $('.masonry-results').masonry({"itemSelector": ".document" });

    $container.imagesLoaded( function() {
        $container.masonry();
    })
});


$(window).load(function() {
    $("#req_select").prop("selectedIndex", -1);
    $('#img_wh').css('display', 'block');
    $('#img_wh').css('max-width', '600px');
    $('#img_wh').css('min-width', '300px');
    $('#img_wh').css('float', 'left');

    $('#img_wh_wrapper').css('width', '600px');
    $('#img_wh_wrapper').css('float', 'left');



    $(window).on('resize', function(){
        var width = $(window).width(); //this = window
        if (width <= 420) {
            $('#btn_jp2').css('left', "2px");
        } else {
            var btnPos1 = $('#btn_jp2').data('button-position');
            $('#btn_jp2').css('left', btnPos1 + 'px' );
        }
    });

})

function add_browser_bookmark(a) {
    if (window.sidebar && window.sidebar.addPanel) { // Mozilla Firefox Bookmark
        alert("Firefox");
        window.sidebar.addPanel(document.title,window.location.href,'');
        return false;
    } else if(window.external && window.external.AddFavorite) { // IE Favorite
        window.external.AddFavorite(location.href,document.title);
        return false;
    } else if(window.opera && window.print) {
        // Opera Hotlist
        this.title=document.title;
        return true;
    } else { // webkit - safari/chrome
        alert('Press ' + (navigator.userAgent.toLowerCase().indexOf('mac') != - 1 ? 'Command/Cmd' : 'CTRL') + ' + D to bookmark this page.');
    }
}

function showReqForm() {
    $( '#req_form' ).dialog({
        dialogClass:"mydialog",
        closeText: "CLOSE",
        width: 600,
        height:350
    });
return false;
}

function submitClose() {
    $('#request').submit();
    closeReqForm();
    return false;
}


function listenClick() {
    if(!($('.panel4'))) return false;
    if($('.panel4').css("display")=='block'){
    $('.panel4').css("display", "none");
    $('.open-close4').text('+');
    }
else {
    $('.panel4').css("display", "block");
    $('.open-close4').text('-');
    }

return false;
}

function select_request(option) {
    if (option.selectedIndex==2){
    $('#form200').css("display", "none");
    $('#form199').show();
    $('.mydialog').css("height", "800px");
    return false;
    }

if (option.selectedIndex==1){
    $('#form199').css("display", "none");
    $('#form200').show();
    $('.mydialog').css("height", "800px");
    return false;
    }

if(option.selectedIndex==0) {
    $('#form199').css("display", "none");
    $('#form200').css("display", "none");
    $('.mydialog').css("height", "auto");
    return false;
    }

}

function handleInput(){;}
function doSubmitEvents(){;}
function validate_appointemnt(){
    if(!$('#form199 #Field1').val()){
        $('#form199 #notice').text("First name cannot be empty.");
    }
    else if(!$('#form199 #Field2').val()){
        $('#form199 #notice').text("Last name cannot be empty.");
    }
    else if(!$('#form199 #Field3').val()){
        $('#form199 #notice').text("Email cannot be empty.");
    }
    else if(!$('#form199 #Field4').val()){
        $('#form199 #notice').text("Year for first choice cannot be empty.");
    }
    else if(!$('#form199 #Field4-1').val()){
        $('#form199 #notice').text("Month for first choice cannot be empty.");
    }
    else if(!$('#form199 #Field4-2').val()){
        $('#form199 #notice').text("Date for first choice cannot be empty.");
    }
    else if(!$('#form199 #Field5').val()){
        $('#form199 #notice').text("Purpose for visit cannot be empty.");
    }
    else {
        return true;
    }

    return false;
}



function validate_request() {

    if(!$('#form200 #Field1').val()){
        $('#form200 #notice').text("First name cannot be empty.");
    }
    else if(!$('#form200 #Field2').val()){
        $('#form200 #notice').text("Last name cannot be empty.");
    }
    else if(!($('#form200 #Field10').val()&&$('#form200 #Field10-1').val()&&$('#form200 #Field10-2').val())){
        $('#form200 #notice').text("Phone number have to be complete.");
    }
    else if(!$('#form200 #Field11').val()){
        $('#form200 #notice').text("Email cannot be empty.");
    }
    else if(!$('#form200 #Field16').val()){
        $('#form200 #notice').text("Accession number cannot be empty.");
    }
    else if(!$('#form200 #Field16').val()){
        $('#form200 #notice').text("Accession number cannot be empty.");
    }
    else if ($('#purpose :checkbox:checked').length == 0){
        $('#form200 #notice').text("Please check the purpose.");
    }
    else if(!$('#form200 #Field221').is(':checked')){
        $('#form200 #notice').text("You must agree the term of use.");
    }
    else {
        return true;
    }

    return false;
}

    function nWin() {
        $('#jp2_panel').html('');

        if(window.innerWidth<650){
            $( '#jp2_modal' ).dialog({
                dialogClass:"jp2dialog",
                closeText: "CLOSE",
                width: window.innerWidth-50,
                height:window.innerHeight-50
            });
        }else{

            $( '#jp2_modal' ).dialog({
                dialogClass:"jp2dialog",
                closeText: "CLOSE",
                width: 650,
                height:700
            });
        }

        $('#jp2_panel').css("display", "block");
        OpenSeadragon({
            id:            "jp2_panel",
            prefixUrl:     "",
            tileSources:   [
                jp2Url
            ],
            zoomInButton:   "zoomin",
            zoomOutButton:  "zoomout",
            homeButton:     "gohome"
            //fullPageButton: "fullpage"
        });
        var left = (650-  $('#jp2_panel').innerWidth())/2;
        $('#jp2_panel').css('left', left);
        $( '#jp2_modal' ).css('height', $('#jp2_panel').innerheight()+50);

    }

function playMp3(id, url) {

    var playIcon = id.replace('player', '.play_icon')+' a';
    if($(playIcon).is('[disabled=disabled]')) {

        return false;
    }

    $(playIcon).attr('disabled','disabled');

    jwplayer(id).setup({
        'autostart': true,
        'file': url,
        'type': 'mp3',
        'width': '100%',
        'height': '30',
        'icons': 'false'
    });
}


