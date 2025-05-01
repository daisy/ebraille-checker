Feature: eBraille checker command line

	Tests the eBraille checker command line interface.



	Background:
		Given EPUB test files located at '/ebraille/cli/files/'


	Rule: check eBraille packaged publications

		Example: check a valid packaged eBraille
			When running `ebraille-checker --profile ebraille {{minimal.ebrl}}`
			Then the return code is 0
			And stderr is empty


	Rule: check eBraille packaged publications

		Example: check a valid packaged eBraille
			When running `ebraille-checker --profile ebraille -mode exp {{minimal}}`
			Then the return code is 0
			And stderr is empty