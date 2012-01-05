
// Manages the initialization and functionality of the patient details view.

prDemo.controllers.PatientDetailsController = Ext.extend(Ext.Controller, {
    view: null,
    store: null,
    
    init: function() {
        this.view = new prDemo.views.PatientDetailsView();
    },
    
    loadPatient: function(pid, callback) {
        var that = this;
        
        // Call PhoneGap to get the patient's details.
        window.services.prService.getPatientDetails
        (
            // Patient id.
            pid,
            
            // Success callback.
            function (result) {
                // Send the model to the view.
                that.view.init(result[0]);
                
                // Set an event handler for the back button.
                that.view.mon(that.view.down('#backButton'), {
                    tap: that.onBackButtonTapped,
                    scope: that
                });
                
                callback();
            },
            
            // Failure callback.
            function (error) {
                window.console.log('Error retrieving details for patient ' + pid + ':');
                window.console.log(error);
            }
        );
    },
    
    onBackButtonTapped: function() {
        // Return to the patient list.
        prDemo.fireEvent('openPatientList');
    }
});
