package com.nashtechnology.backoffice.data

/**
 * 
 * @author z981057
 *
 */
class ScratchOff {
	
	Integer gameNumber
	String gameName
	Integer gamePrice
	Integer gameSize
	Character active
	Integer boxNo	
	
    static constraints = {
		gameNumber unique: true
    }
	
}
