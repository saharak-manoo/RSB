/** @format */

import { Controller } from '@hotwired/stimulus';
import { get, patch } from '@rails/request.js';
import Choices from 'choices.js';
import { Datepicker } from 'vanillajs-datepicker';

export default class extends Controller {
	static values = {
		productsBranchProductsPath: String,
	};

	connect() {
		this.setupSelected();
		this.setupDatePicker();
	}

	setupSelected() {
		let selectorAll = document.querySelectorAll('select.use-search-select');
		selectorAll.forEach((e) => {
			new Choices(e, { shouldSort: false });
		});
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

	onChangeStatus(event) {
		let value = +event.target.value;
		let forImport = document.getElementById('for-import-or-change');
		let forExport = document.getElementById('for-export');
		if (value === 0 || value === 2) {
			forImport.classList.remove('d-none');
			forExport.classList.add('d-none');
		} else {
			forImport.classList.add('d-none');
			forExport.classList.remove('d-none');
		}
	}

	cloneInput(event) {
		let value = +event.target.value;
		let exportFile = document.querySelector('div.show-input-list');
		exportFile.innerHTML = ''

		for (let index = 0; index < value; index++) {
			let htmlText = `<div class="row">
												<div class="col-sm-4">
													<div class="form-group string optional branch_product_stocks_date">
														<label class="string optional" for="branch_product_stocks_attributes_${index}_date">Date</label>
														<input class="form-control string optional use-datepicker mt-1 datepicker-input" type="text" name="branch_product[stocks_attributes][${index}][date]" id="branch_product_stocks_attributes_${index}_date">
													</div>
												</div>
												<div class="col-sm-4">
													<div class="form-group numeric optional branch_product_stocks_price">
														<label class="numeric optional" for="branch_product_stocks_attributes_${index}_price">Price</label>
														<input class="form-control numeric numeric optional mt-1" type="number" step="any" name="branch_product[stocks_attributes][${index}][price]" id="branch_product_stocks_attributes_${index}_price">
													</div>
												</div>
											</div>`;

			let template = document.createElement('template');
			template.innerHTML = htmlText;

			exportFile.appendChild(template.content);
		}

		this.setupDatePicker();
		exportFile.classList.remove("d-none")
	}
}
