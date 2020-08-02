class PagesController < ApplicationController
  def home

    set_meta_tags title: 'Welcome to The Ballot Book',
    site: 'The Ballot Book',
    description: 'A comprehensive database of elected officials, districts, and campaign finance for all of San Diego County.', 
            twitter: {
              card: "summary",
              site: "@theballotbook",
              title: "Welcome to the Ballot Book",
              description:  'A comprehensive database of elected officials, districts, and campaign finance for all of San Diego County.',
              image: '/logos/BallotBook_Twitter_card.png'
            }
  end
end
