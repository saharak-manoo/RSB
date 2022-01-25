/** @format */

import { Controller } from '@hotwired/stimulus';
import Choices from 'choices.js';
import { Datepicker } from 'vanillajs-datepicker';
import dayjs from 'dayjs';

export default class extends Controller {
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

	onChangeStatus(event) {
		let value = +event.target.value;
		let forImport = document.getElementById('for-import-or-change');
		let forExport = document.getElementById('for-export');
		if (value === 0 || value === 2) {
			forImport.classList.remove('d-none');
			forExport.classList.add('d-none');
			forImport.querySelector(
				"input[name='stock_history[qty]']"
			).disabled = false;
			forExport.querySelector(
				"input[name='stock_history[qty]']"
			).disabled = true;
		} else {
			forImport.classList.add('d-none');
			forExport.classList.remove('d-none');
			forImport.querySelector(
				"input[name='stock_history[qty]']"
			).disabled = true;
			forExport.querySelector(
				"input[name='stock_history[qty]']"
			).disabled = false;
		}
	}

	cloneInput(event) {
		let value = +event.target.value;
		let exportFile = document.querySelector('div.show-input-list');
		exportFile.innerHTML = '';

		for (let index = 0; index < value; index++) {
			let htmlText = `<div class="row">
												<div class="col-sm-4">
													<div class="form-group string required stock_history_orders_sold_at">
														<label class="string required" for="stock_history_orders_attributes_${index}_sold_at">ขายเมื่อ <abbr title="required">*</abbr></label>
														<input class="form-control string required use-datepicker mt-1 datepicker-input" type="text" name="stock_history[orders_attributes][${index}][sold_at]" id="stock_history_orders_attributes_${index}_sold_at"
															value="${dayjs().format('DD/MM/YYYY')}">
													</div>
												</div>
												<div class="col-sm-4">
													<div class="form-group decimal required stock_history_orders_price">
														<label class="decimal required" for="stock_history_orders_attributes_0_price">ราคา <abbr title="required">*</abbr></label>
														<input class="form-control numeric decimal required mt-1" value="0" type="number" step="any" name="stock_history[orders_attributes][${index}][price]" id="stock_history_orders_attributes_${index}_price">
													</div>
												</div>
											</div>`;

			let template = document.createElement('template');
			template.innerHTML = htmlText;

			exportFile.appendChild(template.content);
		}

		this.setupDatePicker();
		exportFile.classList.remove('d-none');
	}
}
