#! /usr/bin/env bash
#
# Copyright (c) 2013, The Regents of the University  of California.
# All rights reserved.
# This software is governed by the ""Simplified BSD License"
# http://opensource.org/licenses/BSD-2-Clause
#
# Author: Kevin Klues <klueska@cs.berkeley.edu>

# A function to tell the local repository to ignore changes to all of the
# .metadata files stored in the repo.  Any new files in this directory 
# are covered by the gitignore, but since gitignore cant be used to ignore
# tracked files, and eclipse likes to change these files alot, we need to tell
# git to ingore them a different way.  This is it.
gitignore_tracked_files() {

  # A list of the metadata files to ignore
  local metadata_files=$( cat <<EOF
  .metadata/.plugins/org.eclipse.core.resources/.projects/nachos-root/.markers
  .metadata/.plugins/org.eclipse.core.resources/.projects/nachos-root/org.eclipse.jdt.core/state.dat
  .metadata/.plugins/org.eclipse.core.resources/.root/.indexes/history.version
  .metadata/.plugins/org.eclipse.core.resources/.root/.indexes/properties.index
  .metadata/.plugins/org.eclipse.core.resources/.root/.indexes/properties.version
  .metadata/.plugins/org.eclipse.core.resources/.root/1.tree
  .metadata/.plugins/org.eclipse.core.resources/.safetable/org.eclipse.core.resources
  .metadata/.plugins/org.eclipse.core.runtime/.settings/org.eclipse.core.resources.prefs
  .metadata/.plugins/org.eclipse.core.runtime/.settings/org.eclipse.debug.ui.prefs
  .metadata/.plugins/org.eclipse.core.runtime/.settings/org.eclipse.jdt.core.prefs
  .metadata/.plugins/org.eclipse.core.runtime/.settings/org.eclipse.jdt.launching.prefs
  .metadata/.plugins/org.eclipse.core.runtime/.settings/org.eclipse.jdt.ui.prefs
  .metadata/.plugins/org.eclipse.core.runtime/.settings/org.eclipse.team.ui.prefs
  .metadata/.plugins/org.eclipse.core.runtime/.settings/org.eclipse.ui.ide.prefs
  .metadata/.plugins/org.eclipse.core.runtime/.settings/org.eclipse.ui.prefs
  .metadata/.plugins/org.eclipse.debug.core/.launches/Project 1.launch
  .metadata/.plugins/org.eclipse.debug.core/.launches/Project 2.launch
  .metadata/.plugins/org.eclipse.debug.core/.launches/Project 3.launch
  .metadata/.plugins/org.eclipse.debug.core/.launches/Project 4.launch
  .metadata/.plugins/org.eclipse.debug.ui/dialog_settings.xml
  .metadata/.plugins/org.eclipse.debug.ui/launchConfigurationHistory.xml
  .metadata/.plugins/org.eclipse.e4.workbench/workbench.xmi
  .metadata/.plugins/org.eclipse.jdt.core/1271342938.index
  .metadata/.plugins/org.eclipse.jdt.core/1288663406.index
  .metadata/.plugins/org.eclipse.jdt.core/1384487945.index
  .metadata/.plugins/org.eclipse.jdt.core/156905802.index
  .metadata/.plugins/org.eclipse.jdt.core/1819685514.index
  .metadata/.plugins/org.eclipse.jdt.core/1833648217.index
  .metadata/.plugins/org.eclipse.jdt.core/2326659272.index
  .metadata/.plugins/org.eclipse.jdt.core/2545238116.index
  .metadata/.plugins/org.eclipse.jdt.core/272178059.index
  .metadata/.plugins/org.eclipse.jdt.core/3000285004.index
  .metadata/.plugins/org.eclipse.jdt.core/3004609673.index
  .metadata/.plugins/org.eclipse.jdt.core/3049183336.index
  .metadata/.plugins/org.eclipse.jdt.core/3266567714.index
  .metadata/.plugins/org.eclipse.jdt.core/3302703152.index
  .metadata/.plugins/org.eclipse.jdt.core/3321539481.index
  .metadata/.plugins/org.eclipse.jdt.core/3435298984.index
  .metadata/.plugins/org.eclipse.jdt.core/3712507179.index
  .metadata/.plugins/org.eclipse.jdt.core/3954040986.index
  .metadata/.plugins/org.eclipse.jdt.core/4238209716.index
  .metadata/.plugins/org.eclipse.jdt.core/4249315662.index
  .metadata/.plugins/org.eclipse.jdt.core/450555687.index
  .metadata/.plugins/org.eclipse.jdt.core/765977872.index
  .metadata/.plugins/org.eclipse.jdt.core/770573466.index
  .metadata/.plugins/org.eclipse.jdt.core/84777399.index
  .metadata/.plugins/org.eclipse.jdt.core/externalLibsTimeStamps
  .metadata/.plugins/org.eclipse.jdt.core/invalidArchivesCache
  .metadata/.plugins/org.eclipse.jdt.core/javaLikeNames.txt
  .metadata/.plugins/org.eclipse.jdt.core/nonChainingJarsCache
  .metadata/.plugins/org.eclipse.jdt.core/savedIndexNames.txt
  .metadata/.plugins/org.eclipse.jdt.core/variablesAndContainers.dat
  .metadata/.plugins/org.eclipse.jdt.launching/.install.xml
  .metadata/.plugins/org.eclipse.jdt.launching/libraryInfos.xml
  .metadata/.plugins/org.eclipse.jdt.ui/OpenTypeHistory.xml
  .metadata/.plugins/org.eclipse.jdt.ui/QualifiedTypeNameHistory.xml
  .metadata/.plugins/org.eclipse.jdt.ui/dialog_settings.xml
  .metadata/.plugins/org.eclipse.pde.core/.cache/clean-cache.properties
  .metadata/.plugins/org.eclipse.ui.ide/dialog_settings.xml
  .metadata/.plugins/org.eclipse.ui.intro/dialog_settings.xml
  .metadata/.plugins/org.eclipse.ui.workbench/dialog_settings.xml
  .metadata/.plugins/org.eclipse.ui.workbench/workingsets.xml
  .metadata/version.ini
  EOF
  )

  # Reset the IFS so we can handle files with spaces in their names
  local o=$IFS
  IFS=$(echo -en "\n\b")
  for f in $metadata_files; do
    git update-index --assume-unchanged "$f"
  done
  IFS=o
}

# Run our functions
gitignore_tracked_files

