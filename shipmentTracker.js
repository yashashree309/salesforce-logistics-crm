import { LightningElement } from 'lwc';
import trackShipment from '@salesforce/apex/ShipmentTrackerController.trackShipment';

export default class ShipmentTracker extends LightningElement {
    trackingNumber = '';
    shipment;
    error;

    handleChange(event) {
        this.trackingNumber = event.target.value;
    }

    handleTrack() {
        trackShipment({ trackingNumber: this.trackingNumber })
            .then((result) => {
                this.shipment = result;
                this.error = undefined;
            })
            .catch((err) => {
                this.shipment = undefined;
                this.error = err.body ? err.body.message : 'Something went wrong';
            });
    }
}