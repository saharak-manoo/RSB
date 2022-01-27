/** @format */

import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
	connect() {
		console.log('Nav -> ');
	}

	showOrHideHeader() {
		if (document.getElementById('db-wrapper').classList.contains('toggled')) {
			document.getElementById('db-wrapper').classList.remove('toggled');
		} else {
			document.getElementById('db-wrapper').classList.add('toggled');
		}
	}
}
