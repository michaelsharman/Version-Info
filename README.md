ColdFusion CFC used to create an HTML comment to display in the source code of a website, indicating what build/version the site is currently running.

Uses the semvar (Semantic Versioning) scheme.

Optionally reads the latest scm version information (from a local build file) and the date of last revision.

##Usage:
```
// Instantiate the Version class inside onApplicationStart()
application.cfcs.version = new Version(path=expandPath("/path_to_build_file"), params={major=2, minor=1, patch=1})

// If you don't want scm build information (just a local semver version)
application.cfcs.version = new Version(params={major=2, minor=1, patch=1});

// To render the HTML comment on the website (probably in the footer etc)
#application.cfcs.version.render()#
```

Generates a comment like:

```
<!-- build 2.1.1 r26400 (2012-10-31 12:21:30 +1100 (Wed, 31 Oct 2012)) -->
```

A sample build file (subversion in this case) might be:

### svn
```
Path: .
URL: https://mysite.com/svn/repos/project/trunk
Repository Root: https://mysite.com/svn/repos
Repository UUID: b3e8f156-12e7-0310-a5fd-c9907ed9d749
Revision: 26400
Node Kind: directory
Schedule: normal
Last Changed Author: msharman
Last Changed Rev: 26400
Last Changed Date: 2012-10-31 12:21:30 +1100 (Wed, 31 Oct 2012)
```

### git
```
commit bbdfb745e1a39ec17911f24b5fcab8f0b54e611c
Merge: b37018a 12f3d57
Author: Michael Sharman <myemail@somedomain.com>
Date:   Thu Jan 31 14:55:19 2013 +1100
```
