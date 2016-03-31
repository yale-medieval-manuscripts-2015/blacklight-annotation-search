//= require blacklight/core
//= require blacklight/checkbox_submit
(function($) {
//change form submit toggle to checkbox
    Blacklight.do_bookmark_toggle_behavior = function() {
        $(Blacklight.do_bookmark_toggle_behavior.selector).bl_checkbox_submit({
            checked_label: "In Favorites",
            unchecked_label: "Add to Favorites",
            progress_label: "Saving...",
            //css_class is added to elements added, plus used for id base
            css_class: "toggle_bookmark"
        });
    };
    Blacklight.do_bookmark_toggle_behavior.selector = "form.bookmark_toggle";

    Blacklight.fix_checkboxes = function() {
        $(".check").each(function() {
            $(this).hide();

            var $image = $("<img src='assets/images/layout/checkbox/unchecked.png' />").insertAfter(this);

            $image.click(function() {
                var $checkbox = $(this).prev(".check");
                $checkbox.prop('checked', !$checkbox.prop('checked'));

                if($checkbox.prop("checked")) {
                    $image.attr("src", "assets/images/layout/checkbox/checked.png");
                } else {
                    $image.attr("src", "assets/images/layout/checkbox/unchecked.png");
                }
            })
        });
    }


    $(document).ready(function() {
        Blacklight.do_bookmark_toggle_behavior();
    });


})(jQuery);