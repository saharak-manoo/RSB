/** @format */

import { Controller } from '@hotwired/stimulus';

import { Datepicker } from 'vanillajs-datepicker';
import Choices from 'choices.js';
import DataTable from 'vanilla-datatables';

export default class extends Controller {
	connect() {
		this.dataTable();
	}

	dataTable() {
		let selecter = 'table.use-data-table';
		let labels = {
			placeholder: 'ค้นหา...',
			perPage: 'แสดง {select} คำขอ ต่อหน้า',
			noRows: 'ไม่มีคำขอ',
			info: 'แสดง {start} ถึง {end} จาก {rows} คำขอ (หน้า {page} จาก {pages})',
		};
		new DataTable(selecter, {
			sortable: true,
			searchable: true,
			serverSide: true,
			labels: labels,
		});
	}
}
