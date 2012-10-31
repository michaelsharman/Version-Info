component output="false" displayname="Version" hint="Reads the latest scm version information (from build.txt) and returns an HTML comment to use in the source of a website"
{

	public Version function init(String path, Struct params = {})
	{
		// version defaults
		variables.version = {
			major = 0,
			minor = 1,
			patch = 0,
			revision = "BER",
			dateChanged = ""
		};
		// extend defaults with user specified version information
		structAppend(variables.version, arguments.params, true);
		// read the build file for the latest scm build information
		if (structKeyExists(arguments, "path") && len(trim(arguments.path)))
		{
			loadBuildFile(path=arguments.path);
		}
		return this;
	}


	/**
	* @hint Reads the version number of this latest build and adds it to instance variables
	* Requires a build file to be in the project (eg build.txt)
	*/
	private void function loadBuildFile(required String path)
	{
		var path = arguments.path;
		var f = "";
		var line = "";
		try
		{
			f = fileOpen(path, "read", "utf-8");
			while(!fileIsEOF(f))
			{
				line = fileReadLine(f);
				if (listFirst(line, ":") == "Revision")
				{
					variables.version.revision = trim(listLast(line, ":"));
				}
				else if (listFirst(line, ":") == "Last Changed Date")
				{
					variables.version.dateChanged = trim(listRest(line, ":"));
				}
			}
		}
		catch (any e)
		{
			writelog(text="Version.loadBuildFile() #e.message#", file=application.applicationName, type="error");
		}
	}


	/**
	* @hint Returns an HTML comment containing the latest svn version number and date
	*/
	public string function render()
	{
		var output = "";
		var revDetail = "";
		var v = variables.version;
		try
		{
			// Did we get a revision number from a build file?
			if (structKeyExists(v, 'revision') && len(v.revision))
			{
				revDetail &= "r#v.revision#";
			}
			// Did we get a date from a build file?
			if (structKeyExists(v, 'dateChanged') && len(v.dateChanged))
			{
				revDetail &= " (#v.dateChanged#)";
			}
			output = "<!-- build #v.major#.#v.minor#.#v.patch# #revDetail# -->";
		}
		catch (any e)
		{
			writeLog(text="Version.render() #cfcatch.message#", type="error", file=application.applicationName);
		}
		return output;
	}

}