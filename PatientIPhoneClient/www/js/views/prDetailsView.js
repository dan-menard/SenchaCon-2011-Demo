
// Details view for patient data.

prDemo.views.PatientDetailsView = Ext.extend(Ext.Panel, {
    fullscreen: true,
    baseCls: 'details',
    
    dockedItems: [
        {
            dock: 'top',
            xtype: 'toolbar',
            title: 'Patient Details'
        },
        {
            dock: 'bottom',
            xtype: 'toolbar',
            id: 'backButtonToolbar',
            
            items: [
                {
                    id: 'backButton',
                    text: 'Back'
                }
            ]
        }
    ],
    
    tpl: [
        '<h2>{lastName}, {firstName}</h2>',
        '<p class=\'subdued\'>Patient Id: {pid}</p>',
        '<dl>',
            '<dt>Diagnosis</dt>',
            '<dd>{diagnosis}</dd>',
            '<dt>Physician</dt>',
            '<dd>{physician}</dd>',
            '<dt>Report</dt>',
            '<dd>{note}</dd>',
        '</dl>',
    ],
    
    init: function(data) {
        this.update(data);
    }
});
