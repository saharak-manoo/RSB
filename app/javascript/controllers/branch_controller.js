/** @format */

import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
	connect() {
		console.log('Hi');
	}

	change(event) {
		console.log('Hi');
	}
}
