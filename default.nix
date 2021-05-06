{ scriptPath ? ./detectDisplays.sh
, scriptName ?
    with lib; removeSuffix ".sh" (last (splitString "/" (toString scriptPath)))
, lib
, runCommandLocal
, makeWrapper
, bash, xrandr, gawk, gnugrep
}:
runCommandLocal scriptName {
  nativeBuildInputs = [ makeWrapper ];
} ''
  makeWrapper ${scriptPath} $out/bin/${scriptName} \
    --prefix PATH : ${lib.makeBinPath [
      bash xrandr gawk gnugrep
    ]}
''
