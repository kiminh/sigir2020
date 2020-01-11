# Variables, customize to your environment
YAHOO_DIR ?= /Users/rolfjagerman/Datasets/Yahoo/set1
ISTELLA_DIR ?= /Users/rolfjagerman/Datasets/istella-s
BUILD ?= build

# Default is to run the entire experimental pipeline
.PHONY: all baselines clicklogs yahoo_clicklogs istella_clicklogs
all: baselines clicklogs
baselines: $(BUILD)/baselines/yahoo.pth $(BUILD)/baselines/istella.pth
yahoo_clicklogs: $(BUILD)/clicklogs/yahoo_1m_perfect.clog
yahoo_clicklogs: $(BUILD)/clicklogs/yahoo_1m_position_eta_0.0.clog
yahoo_clicklogs: $(BUILD)/clicklogs/yahoo_1m_position_eta_0.5.clog
yahoo_clicklogs: $(BUILD)/clicklogs/yahoo_1m_position_eta_0.75.clog
yahoo_clicklogs: $(BUILD)/clicklogs/yahoo_1m_position_eta_1.0.clog
yahoo_clicklogs: $(BUILD)/clicklogs/yahoo_1m_position_eta_1.25.clog
yahoo_clicklogs: $(BUILD)/clicklogs/yahoo_1m_position_eta_1.5.clog
yahoo_clicklogs: $(BUILD)/clicklogs/yahoo_1m_position_eta_2.0.clog
yahoo_clicklogs: $(BUILD)/clicklogs/yahoo_1m_nearrandom_eta_1.0.clog
istella_clicklogs: $(BUILD)/clicklogs/istella_1m_perfect.clog
istella_clicklogs: $(BUILD)/clicklogs/istella_1m_position_eta_0.0.clog
istella_clicklogs: $(BUILD)/clicklogs/istella_1m_position_eta_0.5.clog
istella_clicklogs: $(BUILD)/clicklogs/istella_1m_position_eta_0.75.clog
istella_clicklogs: $(BUILD)/clicklogs/istella_1m_position_eta_1.0.clog
istella_clicklogs: $(BUILD)/clicklogs/istella_1m_position_eta_1.25.clog
istella_clicklogs: $(BUILD)/clicklogs/istella_1m_position_eta_1.5.clog
istella_clicklogs: $(BUILD)/clicklogs/istella_1m_position_eta_2.0.clog
istella_clicklogs: $(BUILD)/clicklogs/istella_1m_nearrandom_eta_1.0.clog
clicklogs: yahoo_clicklogs istella_clicklogs


# Baseline rankers trained on fractions of data
$(BUILD)/baselines/yahoo.pth : | $(BUILD)/baselines/
	python -m experiments.baseline --train_data $(YAHOO_DIR)/train.txt \
		--vali_data $(YAHOO_DIR)/vali.txt \
		--output $(BUILD)/baselines/yahoo.pth \
		--optimizer sgd \
		--lr 0.0001 \
		--fraction 0.001

$(BUILD)/baselines/istella.pth : | $(BUILD)/baselines/
	python -m experiments.baseline --train_data $(ISTELLA_DIR)/train.txt \
		--vali_data $(ISTELLA_DIR)/vali.txt \
		--output $(BUILD)/baselines/istella.pth \
		--optimizer sgd \
		--lr 0.001 \
		--fraction 0.001

$(BUILD)/baselines/ :
	mkdir -p $(BUILD)/baselines/


# Click logs generated by baseline rankers
$(BUILD)/clicklogs/yahoo_1m_perfect.clog : $(BUILD)/baselines/yahoo.pth | $(BUILD)/clicklogs/
	python -m experiments.simulate_clicks --input_data $(YAHOO_DIR)/train.txt \
		--ranker $(BUILD)/baselines/yahoo.pth \
		--output_log $@ \
		--sessions 10_000_000 \
		--max_clicks 1_000_000 \
		--behavior perfect

$(BUILD)/clicklogs/yahoo_1m_position_eta_0.0.clog : $(BUILD)/baselines/yahoo.pth | $(BUILD)/clicklogs/
	python -m experiments.simulate_clicks --input_data $(YAHOO_DIR)/train.txt \
		--ranker $(BUILD)/baselines/yahoo.pth \
		--output_log $@ \
		--sessions 10_000_000 \
		--max_clicks 1_000_000 \
		--behavior position \
		--eta 0.0

$(BUILD)/clicklogs/yahoo_1m_position_eta_0.5.clog : $(BUILD)/baselines/yahoo.pth | $(BUILD)/clicklogs/
	python -m experiments.simulate_clicks --input_data $(YAHOO_DIR)/train.txt \
		--ranker $(BUILD)/baselines/yahoo.pth \
		--output_log $@ \
		--sessions 10_000_000 \
		--max_clicks 1_000_000 \
		--behavior position \
		--eta 0.5

$(BUILD)/clicklogs/yahoo_1m_position_eta_0.75.clog : $(BUILD)/baselines/yahoo.pth | $(BUILD)/clicklogs/
	python -m experiments.simulate_clicks --input_data $(YAHOO_DIR)/train.txt \
		--ranker $(BUILD)/baselines/yahoo.pth \
		--output_log $@ \
		--sessions 10_000_000 \
		--max_clicks 1_000_000 \
		--behavior position \
		--eta 0.75

$(BUILD)/clicklogs/yahoo_1m_position_eta_1.0.clog : $(BUILD)/baselines/yahoo.pth | $(BUILD)/clicklogs/
	python -m experiments.simulate_clicks --input_data $(YAHOO_DIR)/train.txt \
		--ranker $(BUILD)/baselines/yahoo.pth \
		--output_log $@ \
		--sessions 10_000_000 \
		--max_clicks 1_000_000 \
		--behavior position \
		--eta 1.0

$(BUILD)/clicklogs/yahoo_1m_position_eta_1.25.clog : $(BUILD)/baselines/yahoo.pth | $(BUILD)/clicklogs/
	python -m experiments.simulate_clicks --input_data $(YAHOO_DIR)/train.txt \
		--ranker $(BUILD)/baselines/yahoo.pth \
		--output_log $@ \
		--sessions 10_000_000 \
		--max_clicks 1_000_000 \
		--behavior position \
		--eta 1.25

$(BUILD)/clicklogs/yahoo_1m_position_eta_1.5.clog : $(BUILD)/baselines/yahoo.pth | $(BUILD)/clicklogs/
	python -m experiments.simulate_clicks --input_data $(YAHOO_DIR)/train.txt \
		--ranker $(BUILD)/baselines/yahoo.pth \
		--output_log $@ \
		--sessions 10_000_000 \
		--max_clicks 1_000_000 \
		--behavior position \
		--eta 1.5

$(BUILD)/clicklogs/yahoo_1m_position_eta_2.0.clog : $(BUILD)/baselines/yahoo.pth | $(BUILD)/clicklogs/
	python -m experiments.simulate_clicks --input_data $(YAHOO_DIR)/train.txt \
		--ranker $(BUILD)/baselines/yahoo.pth \
		--output_log $@ \
		--sessions 10_000_000 \
		--max_clicks 1_000_000 \
		--behavior position \
		--eta 2.0

$(BUILD)/clicklogs/yahoo_1m_nearrandom_eta_1.0.clog : $(BUILD)/baselines/yahoo.pth | $(BUILD)/clicklogs/
	python -m experiments.simulate_clicks --input_data $(YAHOO_DIR)/train.txt \
		--ranker $(BUILD)/baselines/yahoo.pth \
		--output_log $@ \
		--sessions 10_000_000 \
		--max_clicks 1_000_000 \
		--behavior nearrandom \
		--eta 1.0



$(BUILD)/clicklogs/istella_1m_perfect.clog : $(BUILD)/baselines/istella.pth | $(BUILD)/clicklogs/
	python -m experiments.simulate_clicks --input_data $(ISTELLA_DIR)/train.txt \
		--ranker $(BUILD)/baselines/istella.pth \
		--output_log $@ \
		--sessions 10_000_000 \
		--max_clicks 1_000_000 \
		--behavior perfect

$(BUILD)/clicklogs/istella_1m_position_eta_0.0.clog : $(BUILD)/baselines/istella.pth | $(BUILD)/clicklogs/
	python -m experiments.simulate_clicks --input_data $(ISTELLA_DIR)/train.txt \
		--ranker $(BUILD)/baselines/istella.pth \
		--output_log $@ \
		--sessions 10_000_000 \
		--max_clicks 1_000_000 \
		--behavior position \
		--eta 0.0

$(BUILD)/clicklogs/istella_1m_position_eta_0.5.clog : $(BUILD)/baselines/istella.pth | $(BUILD)/clicklogs/
	python -m experiments.simulate_clicks --input_data $(ISTELLA_DIR)/train.txt \
		--ranker $(BUILD)/baselines/istella.pth \
		--output_log $@ \
		--sessions 10_000_000 \
		--max_clicks 1_000_000 \
		--behavior position \
		--eta 0.5

$(BUILD)/clicklogs/istella_1m_position_eta_0.75.clog : $(BUILD)/baselines/istella.pth | $(BUILD)/clicklogs/
	python -m experiments.simulate_clicks --input_data $(ISTELLA_DIR)/train.txt \
		--ranker $(BUILD)/baselines/istella.pth \
		--output_log $@ \
		--sessions 10_000_000 \
		--max_clicks 1_000_000 \
		--behavior position \
		--eta 0.75

$(BUILD)/clicklogs/istella_1m_position_eta_1.0.clog : $(BUILD)/baselines/istella.pth | $(BUILD)/clicklogs/
	python -m experiments.simulate_clicks --input_data $(ISTELLA_DIR)/train.txt \
		--ranker $(BUILD)/baselines/istella.pth \
		--output_log $@ \
		--sessions 10_000_000 \
		--max_clicks 1_000_000 \
		--behavior position \
		--eta 1.0

$(BUILD)/clicklogs/istella_1m_position_eta_1.25.clog : $(BUILD)/baselines/istella.pth | $(BUILD)/clicklogs/
	python -m experiments.simulate_clicks --input_data $(ISTELLA_DIR)/train.txt \
		--ranker $(BUILD)/baselines/istella.pth \
		--output_log $@ \
		--sessions 10_000_000 \
		--max_clicks 1_000_000 \
		--behavior position \
		--eta 1.25

$(BUILD)/clicklogs/istella_1m_position_eta_1.5.clog : $(BUILD)/baselines/istella.pth | $(BUILD)/clicklogs/
	python -m experiments.simulate_clicks --input_data $(ISTELLA_DIR)/train.txt \
		--ranker $(BUILD)/baselines/istella.pth \
		--output_log $@ \
		--sessions 10_000_000 \
		--max_clicks 1_000_000 \
		--behavior position \
		--eta 1.5

$(BUILD)/clicklogs/istella_1m_position_eta_2.0.clog : $(BUILD)/baselines/istella.pth | $(BUILD)/clicklogs/
	python -m experiments.simulate_clicks --input_data $(ISTELLA_DIR)/train.txt \
		--ranker $(BUILD)/baselines/istella.pth \
		--output_log $@ \
		--sessions 10_000_000 \
		--max_clicks 1_000_000 \
		--behavior position \
		--eta 2.0

$(BUILD)/clicklogs/istella_1m_nearrandom_eta_1.0.clog : $(BUILD)/baselines/istella.pth | $(BUILD)/clicklogs/
	python -m experiments.simulate_clicks --input_data $(ISTELLA_DIR)/train.txt \
		--ranker $(BUILD)/baselines/istella.pth \
		--output_log $@ \
		--sessions 10_000_000 \
		--max_clicks 1_000_000 \
		--behavior nearrandom \
		--eta 1.0

$(BUILD)/clicklogs/ :
	mkdir -p $(BUILD)/clicklogs/


# Results
include makescripts/yahoo_optimizers.mk
include makescripts/yahoo_batch_sizes.mk
include makescripts/istella_optimizers.mk
include makescripts/istella_batch_sizes.mk

$(BUILD)/results/optimizers/ :
	mkdir -p $(BUILD)/results/optimizers/

$(BUILD)/results/batch_sizes/ :
	mkdir -p $(BUILD)/results/batch_sizes/

$(BUILD)/results/etas/ :
	mkdir -p $(BUILD)/results/etas/
