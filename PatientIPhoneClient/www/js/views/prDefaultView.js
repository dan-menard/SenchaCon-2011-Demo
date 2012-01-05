
// Root view.

prDemo.views.DefaultView = Ext.extend(Ext.Container, {
    fullscreen: true,
    
    layout: {
        type: 'card'
    },
    
    init: function(views) {
        // Add each view to our card layout.
        for (var i=0; i<views.length; i++)
        {
            this.add(views[i]);
        }
    },
    
    loadView: function(viewIndex) {
        this.layout.setActiveItem(viewIndex);
        this.doLayout();
    }
});
