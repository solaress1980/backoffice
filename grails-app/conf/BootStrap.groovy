import com.nashtechnology.backoffice.data.ScratchOff
import org.codehaus.groovy.grails.io.support.ClassPathResource


/**
 * 
 * This class runs initially during application startup. 
 * 
 * It reads through a csv file to create initial DB entry for Scratch off tickets
 * 
 * @author z981057
 *
 */
class BootStrap {

    def init = { servletContext ->
		log.debug('load scratch off data')
		
		new ClassPathResource("data/scratchoff.csv").file.toCsvReader(['skipLines':1]).eachLine { tokens ->
			log.debug('add scratch off: ' + tokens[0].toInteger() )
			def activeFlag = false
			if (tokens[3]=='Y'||tokens[3]=='y') { activeFlag = true }
			 
			def newScratchOff = new ScratchOff(
				gameNumber: tokens[0].toInteger(),	//game number
				gameName: tokens[1],	//game name
				gamePrice: tokens[2].toInteger(), //game price
				gameSize: tokens[3].toInteger(),
				active: tokens[4],
				boxNo: tokens[5])
			
			if(!newScratchOff.save(flush:true)) {	
				newScratchOff.errors.each {
					println it
				}
			}
		}
    }
	
    def destroy = {
		
    }
}
