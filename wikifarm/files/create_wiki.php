<?php
require_once '/var/www/mediawiki/maintenance/Maintenance.php';

define( 'MEDIAWIKI_INSTALL', true );
define( 'MW_CONFIG_CALLBACK', 'Installer::overrideConfig' );

class CreateWiki extends Maintenance {
	function __construct() {
		parent::__construct();

		$this->addDescription( "CLI-based MediaWiki installation.\n" .
			"Default options are indicated in parentheses." );

		$this->addArg( 'name', 'The name of the wiki (MediaWiki)', false );
		$this->addArg( 'admin', 'The username of the wiki administrator.' );
		$this->addOption( 'pass', 'The password for the wiki administrator.', false, true );
		$this->addOption( 'dbuser', 'The user to use for normal operations (wikiuser)', false, true );
		$this->addOption( 'dbpass', 'The password for the DB user for normal operations', false, true );
		$this->addOption( 'installdbuser', 'The user to use for installing (root)', false, true );
		$this->addOption( 'installdbpass', 'The password for the DB user to install as.', false, true );
		$this->addOption( 'dbname', 'The database name (my_wiki)', false, true );
		$this->addOption( 'dbserver', 'The database host (localhost)', false, true );
	}

	function execute() {

		$siteName = $this->getArg( 0, 'MediaWiki' );
		$adminName = $this->getArg( 1 );

		try {
			$installer = InstallerOverrides::getCliInstaller( $siteName, $adminName, $this->mOptions );
		} catch ( \MediaWiki\Installer\InstallException $e ) {
			$this->output( $e->getStatus()->getMessage( false, false, 'en' )->text() . "\n" );
			return false;
		}

		$result = $installer->performInstallation(
			[ $installer, 'startStage' ],
			[ $installer, 'endStage' ]
		);
		// PerformInstallation bails on a fatal, so make sure the last item
		// completed before giving 'next.' Likewise, only provide back on failure
		$status = end( $result );
		if ( !$status->isGood() ) {
			$installer->showStatusMessage( $status );
			return false;
		}
		return true;
	}
}

$maintClass = CreateWiki::class;

require_once RUN_MAINTENANCE_IF_MAIN;
