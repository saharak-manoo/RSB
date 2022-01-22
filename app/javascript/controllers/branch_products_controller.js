/** @format */

import { Controller } from '@hotwired/stimulus';
import { get, patch } from '@rails/request.js';
import Choices from 'choices.js';

export default class extends Controller {
	static targets = ['branchSelect'];
	static values = {
		productsBranchProductsPath: String,
	};

	connect() {
		new Choices(this.branchSelectTarget, { shouldSort: false });
		this.changeBranch();
	}

	getTarget(id, event) {
		return event?.target == null ? document.getElementById(id) : event?.target;
	}

	changeBranch(event) {
		let target = this.getTarget('branch-select', event);
		let params = new URLSearchParams();
		params.append('branch_id', target.value);

		get(`${this.productsBranchProductsPathValue}?${params}`, {
			responseKind: 'turbo-stream',
		});
	}

	add(event) {
		let showVal = event.target.id.replace('add-', 'show-value-');
		document.getElementById(showVal).value =
			parseInt(document.getElementById(showVal).value, 10) + 1;
		this.updateQty(null, showVal);
	}

	remove(event) {
		let showVal = event.target.id.replace('remove-', 'show-value-');
		document.getElementById(showVal).value =
			parseInt(document.getElementById(showVal).value, 10) - 1;
		this.updateQty(null, showVal);
	}

	updateQty(event, id) {
		let target = this.getTarget(id, event);
		let cardVal = target.id.replace('show-value-', 'card-');
		let urlValue = document.getElementById(cardVal).dataset.pathValue;

		patch(urlValue, {
			body: JSON.stringify({ branch_product: { qty: target.value } }),
			responseKind: 'json',
		});
	}

	searchProduct(event) {
		let target = this.getTarget('branch-select', null);
		let params = new URLSearchParams();
		params.append('branch_id', target.value);
		params.append('keyword', event.target.value);


		get(`${this.productsBranchProductsPathValue}?${params}`, {
			responseKind: 'turbo-stream',
		});
	}
}
