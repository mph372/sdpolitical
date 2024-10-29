import pandas as pd
import numpy as np
from collections import defaultdict

TOTAL_REGISTERED_VOTERS = 1983767

def simulate_election_results():
    # Read the template CSV file
    file_path = '/Users/masonherron/Projects/sdpolitical/data/2024_election_results.csv'
    output_dir = '/Users/masonherron/Projects/sdpolitical/data/'
    
    # Read the original file and find the header row
    with open(file_path, 'r') as f:
        lines = f.readlines()
    
    header_row_index = next(i for i, line in enumerate(lines) if line.startswith('Contest Name'))
    df = pd.read_csv(file_path, skiprows=header_row_index)
    
    # Create stages of completion (30%, 60%, 95%)
    stages = [0.3, 0.6, 0.95]
    
    for stage_num, completion_rate in enumerate(stages, 1):
        stage_df = df.copy()
        
        # Calculate countywide statistics
        expected_turnout = TOTAL_REGISTERED_VOTERS * np.random.uniform(0.45, 0.55)
        total_ballots_cast = int(expected_turnout * completion_rate)
        
        mail_ballot_ratio = np.random.uniform(0.65, 0.75)
        mail_ballots = int(total_ballots_cast * mail_ballot_ratio)
        vote_center_ballots = total_ballots_cast - mail_ballots
        
        for contest_name in stage_df['Contest Name'].unique():
            contest_mask = stage_df['Contest Name'] == contest_name
            candidates = stage_df[contest_mask]
            
            total_precincts = candidates['Number Of Precincts'].iloc[0]
            if pd.isna(total_precincts):
                continue
                
            contest_ratio = float(total_precincts) / 2669
            contest_votes = int(total_ballots_cast * contest_ratio)
            
            vote_shares = generate_vote_shares(len(candidates))
            
            for idx, (index, candidate) in enumerate(candidates.iterrows()):
                vote_count = int(contest_votes * vote_shares[idx])
                mail_votes = int(vote_count * mail_ballot_ratio)
                vote_center_votes = vote_count - mail_votes
                provisional_votes = int(vote_count * 0.01)
                
                stage_df.loc[index, 'Mail Ballots Votes'] = mail_votes
                stage_df.loc[index, 'Vote Center Ballots Votes'] = vote_center_votes
                stage_df.loc[index, 'Provisional Votes'] = provisional_votes
                stage_df.loc[index, 'Total Votes'] = vote_count
                stage_df.loc[index, 'Ballots Cast'] = contest_votes
                stage_df.loc[index, 'Precincts Reported'] = int(total_precincts * completion_rate)
        
        # Add header rows
        header_rows = pd.DataFrame([
            [''] * len(stage_df.columns),  # First blank row
            [''] * len(stage_df.columns)   # Second blank row
        ], columns=stage_df.columns)
        
        final_df = pd.concat([header_rows, stage_df], ignore_index=True)
        
        # Save this stage
        output_file = f'{output_dir}election_results_stage_{stage_num}.csv'
        final_df.to_csv(output_file, index=False)
        
        print(f"\nStage {stage_num} Statistics ({completion_rate*100}% Complete):")
        print("-" * 50)
        print(f"Registered Voters: {TOTAL_REGISTERED_VOTERS:,}")
        print(f"Ballots Cast: {total_ballots_cast:,}")
        print(f"Mail Ballots: {mail_ballots:,}")
        print(f"Vote Center Ballots: {vote_center_ballots:,}")
        print(f"Outstanding Ballots: {int(expected_turnout - total_ballots_cast):,}")
        print(f"Current Turnout: {(total_ballots_cast/TOTAL_REGISTERED_VOTERS)*100:.1f}%")

def generate_vote_shares(num_candidates):
    """Generate realistic vote shares based on number of candidates"""
    if num_candidates == 2:
        base = 0.5
        variance = np.random.uniform(0.02, 0.15)
        shares = [base + variance, base - variance]
    else:
        if num_candidates >= 3:
            alphas = np.ones(num_candidates)
            alphas[0:2] = 3.0  # Give major party candidates higher weight
            raw_shares = np.random.dirichlet(alphas)
        else:
            raw_shares = np.random.dirichlet(np.ones(num_candidates) * 0.5)
        shares = sorted(raw_shares, reverse=True)
    
    return shares

if __name__ == "__main__":
    simulate_election_results()