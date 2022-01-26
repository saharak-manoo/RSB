/** @format */

import { Controller } from '@hotwired/stimulus';
import Choices from 'choices.js';

export default class extends Controller {
	connect() {
		this.setupSearchSelect();
	}

	setupSearchSelect() {
		let selectorAll = document.querySelectorAll('select.use-search-select');
		selectorAll.forEach((e) => {
			new Choices(e, { shouldSort: false });
		});
	}
}
