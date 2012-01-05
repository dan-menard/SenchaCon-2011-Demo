
// Manages the initialization and functionality of the patient list view.

prDemo.controllers.PatientListController = Ext.extend(Ext.Controller, {
    view: null,
    store: null,
    
    init: function(callback) {
        var that = this;
        this.view = new prDemo.views.PatientListView();
        
        // Call PhoneGap to get the list.
        window.services.prService.getPatientList
        (
            // Success callback.
            function (result) {
                // Create a Sencha model object for the view.
                that.store = new Ext.data.Store({
                    model: 'PatientListItem',
                    data: result
                });
                
                // Send the model to the view.
                that.view.init(that.store);
                
                // Set an event handler for the list items.
                that.view.mon(that.view.el, {
                    tap: that.onListItemSelected,
                    scope: that,
                    delegate: '.x-list-item'
                });
                
                callback();
            },
            
            // Failure callback.
            function (error) {
                window.console.log('Error retrieving patient list:');
                window.console.log(error);
            }
        );
    },
    
    onListItemSelected: function(event, target) {
        // Get the selected patient's id, and use it to open the details view.
        var pid = this.view.down('#patientList').getSelectedRecords()[0].data.pid;
        prDemo.fireEvent('openPatientDetails', pid);
    }
});
