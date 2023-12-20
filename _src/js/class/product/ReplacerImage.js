class ReplacerImage
{

    constructor(selector_parent, selector_option, selector_gallery, selector_container_option) {

        this.parent = $(selector_parent);
        this.options = $(selector_option);
        this.gallery = $(selector_gallery);
        this.selector_container_option = selector_container_option;
        this.preview =  this.gallery.first().attr("src");

        if(this.parent.length > 0)
        {
            this.initialization()
        }
    }

    initialization()
    {
        var self = this;
        $(this.options).hover(
            function() {
                $(this).addClass( "hover" );
                if($(this).data('product'))
                {
                    self.getProduct($(this).data('product'));
                }
            }, function()  {
                $(this).removeClass( "hover" );
            }
        );

        $(this.options.closest(self.selector_container_option)).hover(
            function(){},
            function(){
                self.gallery.first().attr("src", self.preview);
            }
        );
    }

    getProduct(id)
    {
        var self = this;
        $.ajax({
            method: "get",
            dataType: "json",
            url: window.location.pathname,
            data: { ajax_action: "prdouctImage", product_id: id },
            success: function (data) {
                self.gallery.first().attr("src", data['src']);
            },
            error: function (data) {},
        });
    }


}

export default ReplacerImage;