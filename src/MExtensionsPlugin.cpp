#include "MExtensionsPlugin.h"

//------------------------------------------------------------------------------
// Plugins
//------------------------------------------------------------------------------
#include "MEmbedFilePlugin.h"
#include "MScriptPlugin.h"
#include "MEventPlugin.h"
#include "MSaveFilePlugin.h"
#include "MScriptableBehaviourPlugin.h"

//------------------------------------------------------------------------------
void StartPlugin(void)
{
	//--------------------------------------------------------------------------
	// Start all the plugins (1.2.3...)
	//--------------------------------------------------------------------------
	MPluginStart(MEmbedFile);
	MPluginStart(MScriptExt);
    MPluginStart(MEvent);
    MPluginStart(MSaveFile);
    MPluginStart(MScriptableBehaviour);
}

//------------------------------------------------------------------------------
void EndPlugin(void)
{
	//--------------------------------------------------------------------------
	// End all the plugins (...3.2.1)
	//--------------------------------------------------------------------------
	MPluginEnd(MScriptableBehaviour);
    MPluginEnd(MSaveFile);
    MPluginEnd(MEvent);
    MPluginEnd(MScriptExt);
	MPluginEnd(MEmbedFile);
}