package semen {
public class State {
    protected var
            _config:Config,
            _seedStepInterval:int,
            _seedGenerationInterval:int;

    public function State(config:Config) {
        _config = config;
        _seedStepInterval = _config.seedStepInterval;
        _seedGenerationInterval = _config.seedGenerationInterval;
    }
}
}
