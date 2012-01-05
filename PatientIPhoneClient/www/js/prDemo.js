
// Stores basic info for a list view.
Ext.regModel('PatientListItem', {});

// Stores detailed info for specific patients.
Ext.regModel('PatientRecordDetails', {});

// Note that we don't need full Sencha models, since we're not using Sencha's
// model binding capabilities. We just need stubs to fill in later.

Ext.regApplication({
    name: 'prDemo',
    launched: false,
    mainView: null,
    listController: null,
    detailsController: null,
    
    launch: function() {
        this.launched = true;
        this.soar();
    },
    
    soar: function() {
        // Only proceed when the device and the app are both ready.
        if (device && this.launched) {
            // Register events for changing between top-level views.
            prDemo.addEvents('openPatientList');
            prDemo.addEvents('openPatientDetails');
            this.mon(prDemo, 'openPatientList', this.loadPatientList);
            this.mon(prDemo, 'openPatientDetails', this.loadPatientDetails);
            
            // Create our views via their controllers.
            this.listController = new prDemo.controllers.PatientListController();
            this.listController.init();
            
            this.detailsController = new prDemo.controllers.PatientDetailsController();
            this.detailsController.init();
            
            // Set up the main view.
            this.mainView = new prDemo.views.DefaultView();
            this.mainView.init([this.listController.view, this.detailsController.view]);
            
            // Start with the list view.
            this.loadPatientList();
        }
    },
    
    loadPatientList: function() {
        this.mainView.loadView(0);
    },
    
    loadPatientDetails: function(pid) {
        var that = this;
        
        this.detailsController.loadPatient(pid, function() {
            that.mainView.loadView(1);
        });
    }
});