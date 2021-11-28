=begin

  NOTE: Functioning code (very rough) is here.

  I want to export as a text file in my "proprietary" format.
  Dot-commands are flush-left. 
  Dot-space is a comment.
  @-tags are flush left also.
  Insert "new" tag @definition, add @end
  @notes tag "text style" at bottom, add @end
  Keep sorted.
  .end at end of term, blank line after

  Select: Include hidden??
  Select: completed, all?


  Example:

  word:         Pluto
  owner:        Wilbur Worker
  state:        in progress
  last_updated: 2021/11/30...
  definition:   Planet, dwarf planet, who the fk knows?
                @image http...
                @image_credits NASA
                @alt_sense Cartoon dog, yo
                @image http...2
                @image_credits Disney
  notes:        This is just a 
                random note
                for an example.

  Exported:

  .term Pluto
  .  Wilbur Worker 
  .  in progress
  .  2021/11/30...
  @definition
  Planet, dwarf planet, who the fk knows?
  @image http...
  @image_credits NASA
  @alt_sense Cartoon dog, yo
  @image http...2
  @image_credits Disney
  @end

  @notes
  This is just a 
  random note
  for an example.
  @end
  .end

=end


require 'ostruct'

def make_word(word:, owner:, status:, updated:, defn: "", notes: "")
  term = OpenStruct.new
  term.word = word
  term.owner = owner
  term.status = status
  term.definition = defn
  term.last_updated = updated
  term.notes = notes
  term
end

class Object      # Kids, don't try this at home.
  def present?    # no present? outside Rails
    return true unless self.nil? || self.empty?  
  end
end

list = 
  [
    make_word(word: "apoapsis", owner: "John Smith", status: "in progress",
              updated: Time.now, 
              defn: <<~DEFN, notes:<<~NOTES),
                    This is just a 
                    fake definition.
                    DEFN
                    Just some 
                    fake notes here.
                    NOTES
    make_word(word: "Bellatrix", owner: "Fred Jones", status: "draft",
              updated: Time.now, 
              defn: <<~DEFN),       # no notes
                    This is just another 
                    fake definition...
                    @see_also Wocka
                    DEFN
    make_word(word: "matrix", owner: "Neo", status: "complete",
              updated: Time.now), # No one can tell you what the Matrix is.
    make_word(word: "zeta", owner: "Hal Fulton", status: "completed",
              updated: Time.now, 
              defn: <<~DEFN, notes:<<~NOTES),
                    Last word of the Greek alphabet, IIRC.
                    DEFN
                    If this were an actual note, 
                    it would probably
                    say something.
                    NOTES
  ]

out = File.new("myexport.txt", "w")

list.each do |word|
  out.puts ". ---------------------------\n "    # just for visibility
  out.puts ".term #{word.word}"
  out.puts ".  #{word.owner}"
  out.puts ".  #{word.status}"
  out.puts ".  #{word.last_updated}"
  out.puts   # blank line just to be pretty
  defn = word.definition
  defn = "(no definition yet)\n" unless defn.present?
  out.puts "@definition\n#{defn}@end"
  notes = word.notes
  if notes.present?     # omit if empty
    out.puts  # blank line between definition and notes
    out.puts "@notes\n#{notes}@end"
  end
  out.puts ".end\n "   # extra blank line
end

out.close
