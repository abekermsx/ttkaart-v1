<%

	Dim arrRatings

	arrRatings = Array(	"2009_1", _
						Array( _
							"Senioren",	_
							Array( _
								"Landelijk Heren", _
									Array(	"eredivisie", 575, "1e divisie", 525, "2e divisie", 475, "3e divisie", 425), _
								"Landelijk Dames", _
									Array(	"eredivisie#", 410, "1e divisie", 340, "2e divisie#", 230, "3e divisie#", 180), _
								"Oost", _
									Array(	"hoofdklasse", 375), _
								"Oost/Zwolle", _
									Array(	"hoofdklasse", 375, "1e klasse", 320, "2e klasse", 260, "3e klasse", 200, "4e klasse", 160, "5e klasse", 120, "6e klasse", 75), _
								"Oost/Ijsselstreek", _
									Array(	"hoofdklasse", 375, "1e klasse", 325, "2e klasse", 275, "3e klasse", 225, "4e klasse", 180, "5e klasse", 130, "6e klasse", 75), _
								"Oost/Twente", _
									Array(	"hoofdklasse", 375, "1e klasse", 320, "2e klasse", 260, "3e klasse", 200, "4e klasse", 160, "5e klasse", 120, "6e klasse", 75), _
								"Noord", _
									Array(	"noordelijke 1e divisie", 375, "noordelijke 2e divisie", 325) , _
								"Noord/Groningen", _
									Array(	"1e klasse", 300, "2e klasse", 250, "3e klasse", 200, "4e klasse", 160, "5e klasse", 100, "6e klasse", 75), _
								"Noord/Drenthe", _
									Array(	"1e klasse", 300, "2e klasse", 250, "3e klasse", 200, "4e klasse", 160, "5e klasse", 100, "6e klasse", 75), _
								"Noord/Friesland", _
									Array(	"1e klasse", 290, "2e klasse", 230, "3e klasse", 180, "4e klasse", 130, "5e klasse", 75), _
								"West", _
										Array(	"hoofdklasse", 375, "1e klasse", 325, "2e klasse", 275, "3e klasse", 225, "4e klasse", 180, "5e klasse", 130, "6e klasse", 75), _
								"Holland Noord", _
										Array(	"hoofdklasse", 375, "1e klasse", 325, "2e klasse", 275, "3e klasse", 225, "4e klasse", 180, "5e klasse", 140, "6e klasse", 90, "7e klasse", 50), _
								"Midden", _
										Array(	"hoofdklasse", 375, "1e klasse", 325, "2e klasse", 275, "3e klasse", 225, "4e klasse", 180, "5e klasse", 130, "6e klasse", 75), _
								"Limburg", _
										Array(	"hoofdklasse", 375, "1e klasse", 325, "2e klasse", 275, "3e klasse", 225, "4e klasse", 170, "5e klasse", 120), _
								"ZuidWest", _
										Array(	"hoofdklasse", 375, "1e klasse", 340, "2e klasse", 290, "3e klasse", 240, "4e klasse", 190, "5e klasse", 140, "6e klasse", 100, "7e klasse", 50) _
							),  _
							"Junioren", _
							Array( _
								"Landelijk Jongens", _
									Array(	"kampioensgroep", 390, "landelijk a", 340, "landelijk b", 300, "landelijk c", 250), _
								"Landelijk Meisjes", _
									Array(	"kampioensgroep", 230, "landelijk a", 180, "landelijk b#", 100), _
								"Oost", _
									Array(	"hoofdklasse", 210, "1e klasse", 160, "2e klasse", 120, "3e klasse", 70, "4e klasse", 20, "5e klasse", -10, "pupillen/welpenklasse", -40), _
								"Oost/Zwolle", _
									Array(	"1e klasse", 160, "2e klasse", 120, "3e klasse", 70, "4e klasse", 20, "5e klasse", -10, "welpenklasse", -40), _
								"Oost/Ijsselstreek", _
									Array(	"1e klasse", 160, "2e klasse", 120, "3e klasse", 70, "4e klasse", 20, "5e klasse", -10, "welpenklasse", -40), _
								"Oost/Twente", _
									Array(	"1e klasse", 160, "2e klasse", 120, "3e klasse", 70, "4e klasse", 20, "5e klasse", -10, "welpenklasse", -40), _
								"Noord", _
									Array(	"noordelijke jeugd divisie", 210, "1e klasse", 160, "2e klasse", 120, "3e klasse", 70, "4e klasse", 30, "pupillen", -10), _
								"West", _
									Array(	"hoofdklasse", 225, "1e klasse", 190, "2e klasse", 155, "3e klasse", 105, "4e klasse", 55, "5e klasse", 5, _
											"pupillen a", 105, "pupillen b", 55, "pupillen c", 5, "pupillen d", -25), _
								"Holland Noord", _
									Array(	"hoofdklasse", 225, "1e klasse", 190, "2e klasse", 140, "3e klasse", 90, "4e klasse", 40, "5e klasse", -10, "6e klasse", -40), _
								"Midden", _
									Array(	"1e klasse", 210, "2e klasse", 140, "3e klasse", 90, "4e klasse", 40, "5e klasse", -10, "6e klasse", -40), _
								"Limburg", _
									Array(	"hoofdklasse", 225, "1e klasse", 190, "2e klasse", 155, "3e klasse", 105, "4e klasse", 55, "5e klasse", 5), _
								"ZuidWest", _
									Array(	"junioren 1e klasse", 225, "junioren 2e klasse", 155, "junioren 3e klasse", 105, "junioren 4e klasse", 55, "junioren 5e klasse", 5, "junioren 6e klasse", 40, _
											"aspiranten 1e klasse", 70, "aspiranten 2e klasse", 30, "aspiranten 3e klasse", 5, "aspiranten 4e klasse", -25) _
							) _
						), _
						"2008_2", _
						Array( _
							"Senioren",	_
							Array( _
								"Landelijk Heren", _
									Array(	"eredivisie", 575, "1e divisie", 525, "2e divisie", 475, "3e divisie", 425), _
								"Landelijk Dames", _
									Array(	"eredivisie#", 410, "1e divisie", 340, "2e divisie#", 230, "3e divisie#", 180), _
								"Oost", _
									Array(	"hoofdklasse", 375), _
								"Oost/Zwolle", _
									Array(	"1e klasse", 320, "2e klasse", 260, "3e klasse", 200, "4e klasse", 160, "5e klasse", 120, "6e klasse", 75), _
								"Oost/Ijsselstreek", _
									Array(	"1e klasse", 325, "2e klasse", 275, "3e klasse", 225, "4e klasse", 180, "5e klasse", 130, "6e klasse", 75), _
								"Oost/Twente", _
									Array(	"1e klasse", 320, "2e klasse", 260, "3e klasse", 200, "4e klasse", 160, "5e klasse", 120, "6e klasse", 75), _
								"Noord", _
									Array(	"noordelijke 1e divisie", 375, "noordelijke 2e divisie", 325) , _
								"Noord/Groningen", _
									Array(	"1e klasse", 300, "2e klasse", 250, "3e klasse", 200, "4e klasse", 160, "5e klasse", 100, "6e klasse", 75), _
								"Noord/Drenthe", _
									Array(	"1e klasse", 300, "2e klasse", 250, "3e klasse", 200, "4e klasse", 160, "5e klasse", 100, "6e klasse", 75), _
								"Noord/Friesland", _
									Array(	"1e klasse", 290, "2e klasse", 230, "3e klasse", 180, "4e klasse", 130, "5e klasse", 75), _
								"West", _
										Array(	"hoofdklasse", 375, "1e klasse", 325, "2e klasse", 275, "3e klasse", 225, "4e klasse", 180, "5e klasse", 130, "6e klasse", 75), _
								"Holland Noord", _
										Array(	"hoofdklasse", 375, "1e klasse", 325, "2e klasse", 275, "3e klasse", 225, "4e klasse", 170, "5e klasse", 120, "6e klasse", 75, "7e klasse", 50), _
								"Midden", _
										Array(	"hoofdklasse", 375, "1e klasse", 325, "2e klasse", 275, "3e klasse", 225, "4e klasse", 180, "5e klasse", 130, "6e klasse", 75), _
								"Limburg", _
										Array(	"hoofdklasse", 375, "1e klasse", 325, "2e klasse", 275, "3e klasse", 225, "4e klasse", 170, "5e klasse", 120) _
							),  _
							"Junioren", _
							Array( _
								"Landelijk Jongens", _
									Array(	"landelijk a", 340, "landelijk b", 300, "landelijk c", 250), _
								"Landelijk Meisjes", _
									Array(	"landelijk a", 200, "landelijk b#", 100), _
								"Oost", _
									Array(	"hoofdklasse", 210), _
								"Oost/Zwolle", _
									Array(	"1e klasse", 160, "2e klasse", 120, "3e klasse", 70, "4e klasse", 20, "5e klasse", -10, "welpenklasse", -40), _
								"Oost/Ijsselstreek", _
									Array(	"1e klasse", 160, "2e klasse", 120, "3e klasse", 70, "4e klasse", 20, "5e klasse", -10, "welpenklasse", -40), _
								"Oost/Twente", _
									Array(	"1e klasse", 160, "2e klasse", 120, "3e klasse", 70, "4e klasse", 20, "5e klasse", -10, "welpenklasse", -40), _
								"Noord", _
									Array(	"noordelijke jeugd divisie", 210, "1e klasse", 160, "2e klasse", 120, "3e klasse", 70, "4e klasse", 30, "pupillen", -10), _
								"West", _
									Array(	"hoofdklasse", 225, "1e klasse", 190, "2e klasse", 155, "3e klasse", 105, "4e klasse", 55, "5e klasse", 5, _
											"pupillen a", 105, "pupillen b", 55, "pupillen c", 5, "pupillen d", -25), _
								"Holland Noord", _
									Array(	"hoofdklasse", 225, "1e klasse", 190, "2e klasse", 140, "3e klasse", 90, "4e klasse", 40, "5e klasse", -10, "6e klasse", -40), _
								"Midden", _
									Array(	"1e klasse", 210, "2e klasse", 140, "3e klasse", 90, "4e klasse", 40, "5e klasse", -10, "6e klasse", -40), _
								"Limburg", _
									Array(	"hoofdklasse", 225, "1e klasse", 190, "2e klasse", 155, "3e klasse", 105, "4e klasse", 55, "5e klasse", 5) _
							) _
						), _
						"2008_1", _
						Array( _	
							"Senioren",	_
							Array( _
								"Landelijk Heren", _
									Array(	"eredivisie", 575, "1e divisie", 525, "2e divisie", 475, "3e divisie", 425), _
								"Landelijk Dames", _
									Array(	"eredivisie#", 430, "1e divisie", 350, "2e divisie#", 250, "3e divisie#", 180), _
								"Oost", _
									Array(	"hoofdklasse", 375), _
								"Oost/Zwolle", _
									Array(	"1e klasse", 320, "2e klasse", 260, "3e klasse", 200, "4e klasse", 160, "5e klasse", 120, "6e klasse", 75), _
								"Oost/Ijsselstreek", _
									Array(	"1e klasse", 325, "2e klasse", 275, "3e klasse", 225, "4e klasse", 180, "5e klasse", 130, "6e klasse", 75), _
								"Oost/Twente", _
									Array(	"1e klasse", 320, "2e klasse", 260, "3e klasse", 200, "4e klasse", 160, "5e klasse", 120, "6e klasse", 75), _
								"Noord", _
									Array(	"noordelijke 1e divisie", 375, "noordelijke 2e divisie", 340), _
								"Noord/Groningen", _
									Array(	"1e klasse", 300, "2e klasse", 250, "3e klasse", 200, "4e klasse", 160, "5e klasse", 100, "6e klasse", 75), _
								"Noord/Drenthe", _
									Array(	"1e klasse", 300, "2e klasse", 250, "3e klasse", 200, "4e klasse", 160, "5e klasse", 100, "6e klasse", 75), _
								"Noord/Friesland", _
									Array(	"1e klasse", 290, "2e klasse", 230, "3e klasse", 180, "4e klasse", 130, "5e klasse", 75), _
								"West", _
									Array(	"hoofdklasse", 375, "1e klasse", 340, "2e klasse", 310, "3e klasse", 275, "4e klasse", 225, "5e klasse", 180, "6e klasse", 130, "7e klasse", 75), _
								"Holland Noord", _
									Array(	"1e klasse", 375, "2e klasse", 325, "3e klasse", 275, "4e klasse", 225, "5e klasse", 170, "6e klasse", 120, "7e klasse", 75, "8e klasse", 50), _
								"Midden", _
									Array(	"hoofdklasse", 375, "1e klasse", 325, "2e klasse", 275, "3e klasse", 225, "4e klasse", 180, "5e klasse", 130, "6e klasse", 75) _
							),  _
							"Junioren", _
							Array( _
								"Landelijk Jongens", _
									Array(	"kampioensgroep", 390, "landelijk a", 340, "landelijk b", 300, "landelijk c", 250), _
								"Landelijk Meisjes", _
									Array(	"kampioensgroep", 240, "landelijk a", 200, "landelijk b/c", 100), _
								"Oost", _
									Array(	"hoofdklasse", 210), _
								"Oost/Zwolle", _
									Array(	"1e klasse", 160, "2e klasse", 120, "3e klasse", 70, "4e klasse", 20, "5e klasse", -10, "welpenklasse", -40), _
								"Oost/Ijsselstreek", _
									Array(	"1e klasse", 160, "2e klasse", 120, "3e klasse", 70, "4e klasse", 20, "5e klasse", -10, "welpenklasse", -40), _
								"Oost/Twente", _
									Array(	"1e klasse", 160, "2e klasse", 120, "3e klasse", 70, "4e klasse", 20, "5e klasse", -10, "welpenklasse", -40), _
								"Noord", _
									Array(	"noordelijke jeugd divisie", 210, "1e klasse", 160, "2e klasse", 120, "3e klasse", 70, "4e klasse", 30, "pupillen", -10), _
								"West", _
									Array(	"hoofdklasse", 225, "1e klasse", 190, "2e klasse", 155, "3e klasse", 105, "4e klasse", 55, "5e klasse", 5, _
											"pupillen a", 105, "pupillen b", 55, "pupillen c", 5, "pupillen d", -25), _
								"Holland Noord", _
									Array(	"hoofdklasse", 225, "1e klasse", 190, "2e klasse", 140, "3e klasse", 90, "4e klasse", 40, "5e klasse", -10, "6e klasse", -40), _
								"Midden", _
									Array(	"1e klasse", 210, "2e klasse", 140, "3e klasse", 90, "4e klasse", 40, "5e klasse", -10, "6e klasse", -40), _
								"Limburg", _
									Array(	"hoofdklasse", 225, "1e klasse", 190, "2e klasse", 155, "3e klasse", 105, "4e klasse", 55, "5e klasse", 5) _
							) _
						), _
						"2007_2", _
						Array( _
							"Senioren",	_
							Array( _
								"Landelijk Heren", _
									Array(	"eredivisie", 575, "1e divisie", 525, "2e divisie", 475, "3e divisie", 425), _
								"Landelijk Dames", _
									Array(	"eredivisie#", 430, "1e divisie", 350, "2e divisie#", 250, "3e divisie#", 180), _
								"Oost", _
									Array(	"hoofdklasse", 375), _
								"Oost/Zwolle", _
									Array(	"1e klasse", 320, "2e klasse", 260, "3e klasse", 200, "4e klasse", 160, "5e klasse", 120, "6e klasse", 75), _
								"Oost/Ijsselstreek", _
									Array(	"1e klasse", 325, "2e klasse", 275, "3e klasse", 225, "4e klasse", 180, "5e klasse", 130, "6e klasse", 75), _
								"Oost/Twente", _
									Array(	"1e klasse", 320, "2e klasse", 260, "3e klasse", 200, "4e klasse", 160, "5e klasse", 120, "6e klasse", 75), _
								"Noord", _
									Array(	"noordelijke 1e divisie", 375, "noordelijke 2e divisie", 340), _
								"Noord/Groningen", _
									Array(	"1e klasse", 300, "2e klasse", 250, "3e klasse", 200, "4e klasse", 160, "5e klasse", 100, "6e klasse", 75), _
								"Noord/Drenthe", _
									Array(	"1e klasse", 300, "2e klasse", 250, "3e klasse", 200, "4e klasse", 160, "5e klasse", 100, "6e klasse", 75), _
								"Noord/Friesland", _
									Array(	"1e klasse", 290, "2e klasse", 230, "3e klasse", 180, "4e klasse", 130, "5e klasse", 75), _
								"West", _
									Array(	"hoofdklasse", 375, "1e klasse", 340, "2e klasse", 310, "3e klasse", 275, "4e klasse", 225, "5e klasse", 180, "6e klasse", 130, "7e klasse", 75), _
								"Holland Noord", _
									Array(	"1e klasse", 375, "2e klasse", 325, "3e klasse", 275, "4e klasse", 225, "5e klasse", 170, "6e klasse", 120, "7e klasse", 75, "8e klasse", 50), _
								"Midden", _
									Array(	"hoofdklasse", 375, "1e klasse", 325, "2e klasse", 275, "3e klasse", 225, "4e klasse", 180, "5e klasse", 130, "6e klasse", 75) _
							),  _
							"Junioren", _
							Array( _
								"Landelijk Jongens", _
									Array(	 "landelijk a", 340, "landelijk b", 300, "landelijk c", 250), _
								"Landelijk Meisjes", _
									Array(	"landelijk a", 200, "landelijk b/c", 100), _
								"Oost", _
									Array(	"hoofdklasse", 210), _
								"Oost/Zwolle", _
									Array(	"1e klasse", 160, "2e klasse", 120, "3e klasse", 70, "4e klasse", 20, "5e klasse", -10, "welpenklasse", -40), _
								"Oost/Ijsselstreek", _
									Array(	"1e klasse", 160, "2e klasse", 120, "3e klasse", 70, "4e klasse", 20, "5e klasse", -10, "welpenklasse", -40), _
								"Oost/Twente", _
									Array(	"1e klasse", 160, "2e klasse", 120, "3e klasse", 70, "4e klasse", 20, "5e klasse", -10, "welpenklasse", -40), _
								"Noord", _
									Array(	"noordelijke jeugd divisie", 210, "1e klasse", 160, "2e klasse", 120, "3e klasse", 70, "4e klasse", 30, "pupillen", -10), _
								"West", _
									Array(	"hoofdklasse", 225, "1e klasse", 190, "2e klasse", 155, "3e klasse", 105, "4e klasse", 55, "5e klasse", 5, _
											"pupillen a", 105, "pupillen b", 55, "pupillen c", 5, "pupillen d", -25), _
								"Holland Noord", _
									Array(	"hoofdklasse", 225, "1e klasse", 190, "2e klasse", 140, "3e klasse", 90, "4e klasse", 40, "5e klasse", -10, "6e klasse", -40), _
								"Midden", _
									Array(	"1e klasse", 210, "2e klasse", 140, "3e klasse", 90, "4e klasse", 40, "5e klasse", -10, "6e klasse", -40) _
							) _
						), _
						"2007_1", _
						Array( _	
							"Senioren",	_
							Array( _
								"Landelijk Heren", _
									Array(	"eredivisie", 575, "1e divisie", 525, "2e divisie", 475, "3e divisie", 425), _
								"Landelijk Dames", _
									Array(	"eredivisie#", 450, "1e divisie", 350, "2e divisie#", 250, "3e divisie#", 180), _
								"Oost", _
									Array(	"hoofdklasse", 375), _
								"Oost/Zwolle", _
									Array(	"1e klasse", 320, "2e klasse", 260, "3e klasse", 200, "4e klasse", 150, "5e klasse", 100, "6e klasse", 50), _
								"Oost/Ijsselstreek", _
									Array(	"1e klasse", 325, "2e klasse", 275, "3e klasse", 225, "4e klasse", 180, "5e klasse", 130, "6e klasse", 75), _
								"Oost/Twente", _
									Array(	"1e klasse", 320, "2e klasse", 260, "3e klasse", 200, "4e klasse", 150, "5e klasse", 100, "6e klasse", 50), _
								"Noord", _
									Array(	"noordelijke 1e divisie", 375, "noordelijke 2e divisie", 340), _
								"Noord/Groningen", _
									Array(	"1e klasse", 300, "2e klasse", 250, "3e klasse", 200, "4e klasse", 150, "5e klasse", 100, "6e klasse", 50), _
								"Noord/Drenthe", _
									Array(	"1e klasse", 300, "2e klasse", 250, "3e klasse", 200, "4e klasse", 150, "5e klasse", 100, "6e klasse", 50), _
								"Noord/Friesland", _
									Array(	"1e klasse", 290, "2e klasse", 230, "3e klasse", 180, "4e klasse", 130, "5e klasse", 75), _
								"West", _
									Array(	"hoofdklasse", 375, "1e klasse", 340, "2e klasse", 310, "3e klasse", 275, "4e klasse", 225, "5e klasse", 180, "6e klasse", 130, "7e klasse", 75), _
								"Holland Noord", _
									Array(	"1e klasse", 375, "2e klasse", 325, "3e klasse", 275, "4e klasse", 225, "5e klasse", 170, "6e klasse", 120, "7e klasse", 75, "8e klasse", 50), _
								"Midden", _
									Array(	"hoofdklasse", 375, "1e klasse", 325, "2e klasse", 275, "3e klasse", 225, "4e klasse", 180, "5e klasse", 130, "6e klasse", 75) _
								),  _
							"Junioren", _
							Array( _
								"Landelijk Jongens", _
									Array(	"kampioensgroep", 380, "landelijk a", 330, "landelijk b", 290, "landelijk c", 240), _
								"Landelijk Meisjes", _
									Array(	"kampioensgroep", 210, "landelijk a", 160, "landelijk b", 100, "landelijk b/c", 100, "landelijk c", 50), _
								"Oost", _
									Array(	"hoofdklasse", 205), _
								"Oost/Zwolle", _
									Array(	"1e klasse", 160, "2e klasse", 110, "3e klasse", 55, "4e klasse", 5, "5e klasse", -25), _
								"Oost/Ijsselstreek", _
									Array(	"1e klasse", 160, "2e klasse", 110, "3e klasse", 55, "4e klasse", 5, "5e klasse", -25), _
								"Oost/Twente", _
									Array(	"1e klasse", 160, "2e klasse", 110, "3e klasse", 55, "4e klasse", 5, "5e klasse", -25), _
								"Noord", _
									Array(	"noordelijke jeugd divisie", 210, "1e klasse", 175, "2e klasse", 130, "3e klasse", 80, "4e klasse", 30, "pupillen", -10), _
								"West", _
									Array(	"hoofdklasse", 225, "1e klasse", 190, "2e klasse", 155, "3e klasse", 105, "4e klasse", 55, "5e klasse", 5, _
											"pupillen a", 105, "pupillen b", 55, "pupillen c", 5, "pupillen d", -25), _
								"Holland Noord", _
									Array(	"hoofdklasse", 225, "1e klasse", 190, "2e klasse", 140, "3e klasse", 90, "4e klasse", 40, "5e klasse", -10, "6e klasse", -40), _
								"Midden", _
									Array(	"1e klasse", 210, "2e klasse", 155, "3e klasse", 90, "4e klasse", 40, "5e klasse", -10, "6e klasse", -40) _
							) _
						), _
						"2006_2", _
						Array( _
							"Senioren",	_
							Array( _
								"Landelijk Heren", _
									Array(	"eredivisie", 575, "1e divisie", 525, "2e divisie", 475, "3e divisie", 425), _
								"Landelijk Dames", _
									Array(	"eredivisie#", 450, "1e divisie", 350, "2e divisie#", 250, "3e divisie#", 180), _
								"Oost", _
									Array(	"hoofdklasse", 375), _
								"Oost/Zwolle", _
									Array(	"1e klasse", 320, "2e klasse", 260, "3e klasse", 200, "4e klasse", 150, "5e klasse", 100, "6e klasse", 50), _
								"Oost/Ijsselstreek", _
									Array(	"1e klasse", 325, "2e klasse", 275, "3e klasse", 225, "4e klasse", 180, "5e klasse", 130, "6e klasse", 75), _
								"Oost/Twente", _
									Array(	"1e klasse", 320, "2e klasse", 260, "3e klasse", 200, "4e klasse", 150, "5e klasse", 100, "6e klasse", 50), _
								"Noord", _
									Array(	"noordelijke 1e divisie", 375, "noordelijke 2e divisie", 340), _
								"Noord/Groningen", _
									Array(	"1e klasse", 300, "2e klasse", 250, "3e klasse", 200, "4e klasse", 150, "5e klasse", 100, "6e klasse", 50), _
								"Noord/Drenthe", _
									Array(	"1e klasse", 300, "2e klasse", 250, "3e klasse", 200, "4e klasse", 150, "5e klasse", 100, "6e klasse", 50), _
								"Noord/Friesland", _
									Array(	"1e klasse", 290, "2e klasse", 230, "3e klasse", 180, "4e klasse", 130, "5e klasse", 75), _
								"West", _
									Array(	"hoofdklasse", 375, "1e klasse", 340, "2e klasse", 310, "3e klasse", 275, "4e klasse", 225, "5e klasse", 180, "6e klasse", 130, "7e klasse", 75), _
								"Holland Noord", _
									Array(	"1e klasse", 375, "2e klasse", 325, "3e klasse", 275, "4e klasse", 225, "5e klasse", 170, "6e klasse", 120, "7e klasse", 75, "8e klasse", 50), _
								"Midden", _
									Array(	"hoofdklasse", 375, "1e klasse", 325, "2e klasse", 275, "3e klasse", 225, "4e klasse", 180, "5e klasse", 130, "6e klasse", 75) _
							),  _
							"Junioren", _
							Array( _
								"Landelijk Jongens", _
									Array(	"landelijk a", 340, "landelijk b", 300, "landelijk c", 250), _
								"Landelijk Meisjes", _
									Array(	"landelijk a", 170, "landelijk b", 100, "landelijk c", 50), _
								"Oost", _
									Array(	"hoofdklasse", 205), _
								"Oost/Zwolle", _
									Array(	"1e klasse", 160, "2e klasse", 110, "3e klasse", 55, "4e klasse", 5, "5e klasse", -25), _
								"Oost/Ijsselstreek", _
									Array(	"1e klasse", 160, "2e klasse", 110, "3e klasse", 55, "4e klasse", 5, "5e klasse", -25), _
								"Oost/Twente", _
									Array(	"1e klasse", 160, "2e klasse", 110, "3e klasse", 55, "4e klasse", 5, "5e klasse", -25), _
								"Noord", _
									Array(	"noordelijke jeugd divisie", 210, "1e klasse", 175, "2e klasse", 130, "3e klasse", 80, "4e klasse", 30, "pupillen", -10), _
								"West", _
									Array(	"hoofdklasse", 225, "1e klasse", 190, "2e klasse", 155, "3e klasse", 105, "4e klasse", 55, "5e klasse", 5, _
											"pupillen a", 105, "pupillen b", 55, "pupillen c", 5, "pupillen d", -25), _
								"Holland Noord", _
									Array(	"hoofdklasse", 225, "1e klasse", 190, "2e klasse", 140, "3e klasse", 90, "4e klasse", 40, "5e klasse", -10, "6e klasse", -40), _
								"Midden", _
									Array(	"1e klasse", 205, "2e klasse", 155, "3e klasse", 90, "4e klasse", 40, "5e klasse", -10, "6e klasse", -40) _
							) _
						) _
					)


	
	Function DisplayPercentages(ByVal strPeriod, ByVal strCategory, ByVal strRegion, ByVal lngRating)
		Dim i
		Dim arrPeriod, arrCategory, arrRegion
		Dim strLevel, lngBasisRating, lngPercentage
		Dim strResult
		
		i = 0 
		
		While arrRatings(i) <> strPeriod
			i=i+2
		Wend
		
		arrPeriod = arrRatings(i+1)
		
		If strCategory = "Senioren" Then arrCategory = arrPeriod(1) Else arrCategory = arrPeriod(3)
		
		i = 0
		
		While arrCategory(i)<>strRegion
			i=i+2
		Wend
		
		arrRegion = arrCategory(i+1)
		
		For i = LBound(arrRegion) To UBound(arrRegion) Step 2
			strLevel = arrRegion(i)
			lngBasisRating = arrRegion(i+1)
		
			If lngRating < lngBasisRating Then
				strResult = strResult & "<tr><td>" & strLevel & "</td><td>0%</td></tr>"
			Else
				If InStr(strLevel, "#") Then
					lngPercentage = (lngRating - lngBasisRating) / 2
				Else
					If lngRating < lngBasisRating+50 Then
						lngPercentage = (lngRating - lngBasisRating) / 2
					Else
						If lngRating < lngBasisRating+100 Then
							lngPercentage = lngRating - lngBasisRating - 25
						Else
							lngPercentage = (lngRating+50-lngBasisRating) / 2
						End If				
					End If
				End If
				
				lngPercentage = CLng(lngPercentage)
				
				If lngPercentage > 100 Then lngPercentage = 100
				
				strResult = strResult & "<tr><td>" & strLevel & "</td><td>" & lngPercentage & "%</td></tr>"
			End If
		
		Next
		
		DisplayPercentages = strResult
	
	End Function
	
%>