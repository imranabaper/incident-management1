using ProcessorService as service from '../../srv/ services';
using from '../../db/schema';

annotate service.Incidents with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'customer_ID',
                Value : customer_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Label : 'urgency_code',
                Value : urgency_code,
            },
            {
                $Type : 'UI.DataField',
                Label : 'status_code',
                Value : status_code,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : '{i18n>Title}',
        },
        {
            $Type : 'UI.DataField',
            Value : customer.name,
            Label : '{i18n>Customer}',
        },
        {
            $Type : 'UI.DataField',
            Value : status.descr,
            Label : '{i18n>Status}',
            Criticality : status.criticality,
        },
        {
            $Type : 'UI.DataField',
            Value : urgency.descr,
            Label : '{i18n>Urgency}',
        },
    ],
    UI.SelectionFields : [
        status_code,
        urgency_code,
    ],
);

annotate service.Incidents with {
    customer @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Customers',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : customer_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'firstName',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'lastName',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'email',
            },
        ],
    }
};

annotate service.Incidents with {
    status @(
        Common.Label : '{i18n>Statuscode}',
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Incidents with {
    urgency @(
        Common.Label : '{i18n>Urgency}',
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Urgency with {
    code @Common.Text : descr
};

annotate service.Status with {
    code @Common.Text : descr
};

