/** @format */

import { Controller } from '@hotwired/stimulus';
import { Datepicker } from 'vanillajs-datepicker';

export default class extends Controller {
	connect() {
		this.setupDatePicker();
	}

	setupDatePicker() {
		let selectorAll = document.querySelectorAll('input.use-datepicker');
		selectorAll.forEach((e) => {
			new Datepicker(e, {
				buttonClass: 'btn',
				format: 'dd/mm/yyyy',
			});
		});
	}
}
