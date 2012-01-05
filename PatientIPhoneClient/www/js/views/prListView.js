
// List-based view for basic patient data.

prDemo.views.PatientListView = Ext.extend(Ext.Panel, {
    fullscreen: true,
    
    dockedItems: [
        {
            dock: 'top',
            xtype: 'toolbar',
            title: 'Choose a Patient'
        },
        {
            dock: 'bottom',
            xtype: 'toolbar'
        }
    ],
    
    items: [
        {
            id: 'patientList',
            xtype: 'list',
            store: null,
            itemTpl: '{lastName}, {firstName}'
        }
    ],
    
    init: function(store) {
        var patientList = this.down('#patientList');
        patientList.bindStore(store);
    }
});
